#' Convert to a Dotto template
#'
#' Format for converting from R Markdown to a `Dotto` document.
#'
#' @details
#' Styling and features are very similar to the ones from the great
#' knitrBootstrap package by Jim Hester :
#' \url{https://github.com/jimhester/knitrBootstrap}
#'
#' @param fig_width Default width (in inches) for figures
#' @param fig_height Default width (in inches) for figures
#' @param fig_caption \code{TRUE} to render figures with captions
#' @param highlight Syntax highlighting style. Supported styles include
#'   "default", "tango", "pygments", "kate", "monochrome", "espresso",
#'   "zenburn", "haddock", and "textmate". Pass \code{NULL} to prevent syntax
#'   highlighting.
#' @param lightbox if TRUE, add lightbox effect to content images
#' @param thumbnails if TRUE display content images as thumbnails
#' @param pandoc_args arguments passed to the pandoc_args argument of rmarkdown \code{\link[rmarkdown]{html_document}}
#' @param md_extensions arguments passed to the md_extensions argument of rmarkdown \code{\link[rmarkdown]{html_document}}
#' @param ... Additional function arguments passed to R Markdown \code{\link[rmarkdown]{html_document}}
#' @return R Markdown output format to pass to \code{\link[rmarkdown]{render}}
#' @import rmarkdown
#' @importFrom htmltools htmlDependency
#' @export
Dotto <- function(fig_width = 6,
                       fig_height = 6,
                       fig_caption = TRUE,
                       highlight = "kate",
                       lightbox = TRUE,
                       thumbnails = TRUE,
                       pandoc_args = NULL,
                       md_extensions = "-autolink_bare_uris",
                       self_contained = FALSE,
                       in_header = c(social_card_protocol_dotto()$open_graph,
                                     social_card_protocol_dotto()$twitter),
                       before_body = here::here("resources/header_post.html"),
                       after_body = c(discus_dotto(),
                                      here::here("resources/footer.html")),
                       ...) {
  default_template(
    template_name = "Dotto",
    template_path = "templates/Dotto.html",
    template_dependencies = list(
      Dotto_dependency()
    ),
    pandoc_args = pandoc_args,
    fig_width = fig_width,
    fig_height = fig_height,
    fig_caption = fig_caption,
    highlight = highlight,
    lightbox = lightbox,
    thumbnails = thumbnails,
    md_extensions = md_extensions,
    self_contained = self_contained,
    in_header = in_header,
    before_body = before_body,
    after_body = after_body,
    # mathjax = mathjax,
    ...
  )
}

# Dependency added manually (not from a library)
Dotto_dependency <- function() {
  htmltools::htmlDependency(name = "Dotto",
                            version = "0.1.0",
                            src = system.file("templates/DataMotto", package = "DataMotto"),
                            head = list(paste0(
                              '<link rel="shortcut icon" href="../../',rmarkdown::site_config(input = here::here())$favicon,'">'
                            )),
                            script = c("Dotto.js"),
                            stylesheet = "site.css",
                            all_files = F)
}

# Open Graph Protocol
social_card_protocol_dotto <- function() {
  dir_name <- basename(getwd())
  base_url <- rmarkdown::site_config(here::here())$base_url
  rmd_path <- list.files(getwd(), full.names = T, pattern = "\\.Rmd$")
  all_yml_metadata <- rmarkdown::yaml_front_matter(rmd_path)
  # ---
  canonical_link = paste0(base_url, glue::glue("/posts/Dotto/{dir_name}/"))
  # ---
  cover_image_url <- resolve_cover_image(rmd_path) %>% stringr::str_remove("^\\.")
  canonical_img_url <- paste0(base_url, cover_image_url)

  # --- Open Graph Card
  og_codes <- sprintf('
  <meta property="og:title" content="%s" />
  <meta property="og:type" content="article">
  <meta property="og:description" content="%s" />
  <meta property="og:url" content="%s" />
  <meta property="og:locale" content="en_US">
  <meta property="og:site_name" content="Data Motto">
  <meta property="og:image" content="%s" />
  ', all_yml_metadata$title, all_yml_metadata$description, canonical_link, canonical_img_url)
  # ---
  og_protocol <- tempfile()
  con <- file(og_protocol, open = "w", encoding = "UTF-8")
  xfun::write_utf8(og_codes, con)
  close(con)
  # --- Twitter Card
  twitter_codes <- sprintf('
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:title" content="%s">
  <meta property="twitter:description" content="%s">
  <meta property="twitter:url" content="%s">
  <meta property="twitter:image" content="%s">
  ', all_yml_metadata$title, all_yml_metadata$description, canonical_link, canonical_img_url)
  # ---
  twitter_protocol <- tempfile()
  con <- file(twitter_protocol, open = "w", encoding = "UTF-8")
  xfun::write_utf8(twitter_codes, con)
  close(con)

  return(list(open_graph = og_protocol, twitter = twitter_protocol))

}


# Add a discus widget to the Dotto page
discus_dotto <- function() {
  dir_name <- basename(getwd())
  disc_codes <- sprintf('
    <section class="mt-5 pt-5">
    <div class="container">
    <div id="disqus_thread"></div>
    <script>
    var disqus_config = function () {
      this.page.url = "%s";
      this.page.identifier = "%s";
    };

  (function() {
    var d = document, s = d.createElement("script");
    s.src = "https://datamotto-com.disqus.com/embed.js";
    s.setAttribute("data-timestamp", +new Date());
    (d.head || d.body).appendChild(s);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<script id="dsq-count-scr" src="//datamotto-com.disqus.com/count.js" async></script>
</div>
</section>
  ', glue::glue("https://datamotto.com/posts/Dotto/{dir_name}/index.html"),
  yaml::read_yaml(".yml")$dotto_id)
  # ---
  temp_file <- tempfile()
  con <- file(temp_file, open = "w", encoding = "UTF-8")
  xfun::write_utf8(disc_codes, con)
  close(con)
  return(temp_file)
}
