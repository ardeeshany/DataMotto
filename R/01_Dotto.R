#' Create the `Dotto` page of DataMotto.com
#'
#' Format for converting from R Markdown to a `Dotto` document.
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
  canonical_link = paste0(base_url, glue::glue("/posts/dotto/{dir_name}/"))
  # ---
  cover_image_url <- resolve_cover_image(rmd_path) %>% stringr::str_remove("^\\.")
  canonical_img_url <- ifelse(stringr::str_detect(cover_image_url, pattern = "^posts"),
                              paste0(base_url, cover_image_url),
                              cover_image_url)

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
    <section class="mt-2 pt-2">
    <div class="container">
    <details class="comments-details">
    <summary class="col-sm-12 alert alert-info">
    <strong><i class="fas fa-comments fa-lg"></i>
    <span class="disqus-comment-count" data-disqus-url="%s" data-disqus-identifier="%s"></span>
    </strong>
    <span class="pl-2">for this Dotto.</span>
    <span>Write yours here!</span>
    </summary>
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
</details>
</div>
</section>
  ',
glue::glue("https://datamotto.com/posts/Dotto/{dir_name}/index.html"),
yaml::read_yaml(".yml")$dotto_id,
glue::glue("https://datamotto.com/posts/Dotto/{dir_name}/index.html"),
yaml::read_yaml(".yml")$dotto_id)
  # ---
  temp_file <- tempfile()
  con <- file(temp_file, open = "w", encoding = "UTF-8")
  xfun::write_utf8(disc_codes, con)
  close(con)
  return(temp_file)
}






Make_Dotto <- function(){
  #rmd_path <- list.files(getwd(), pattern = "\\.Rmd$", full.names = T)
  #rmarkdown::render(input = rmd_path,output_format = "html_document",output_file = "sdf",
  #                  clean = F)
  #DataMotto::Dotto()
  rmarkdown::render(list.files(getwd(), pattern = "\\.Rmd$", full.names = T),
                    html_document(self_contained = F))
  con <- file(paste0(getwd(),"/.json"), open = "w", encoding = "UTF-8")
  xfun::write_utf8(Config_Dotto_to_json(getwd()), con = con)
  close(con)
  DataMotto::Dotto()

}



# Make Dotto from the config json -------------

Dotto_top_header <- function(metadata) {

  # Datamotto logo part ------
  col_1 <- sprintf('
<div class="col-1 d-flex justify-content-start align-items-center header-logo">
<img id="logo" src="../../../assets/img/logo.svg" />
</div>
')

  # Title, Description, categories ------
  col_2 <- sprintf('
<div class="col-6 col-sm-7">
<div class="header-title">
<h6 class="dotto-header-maintitle">
%s
</h6>
<p class="dotto-header-description">
%s
</p>
<p class="dotto-header-tags">
<i class="fas fa-tags"></i>&nbsp; %s
</p>
</div>
</div>
',
metadata$title,
metadata$description,
paste0(metadata$categories, collapse = ""))

  # Dotto Star -------
  col_3 <- sprintf('
<div class="col-1 d-flex justify-content-center align-items-center">
<button class="btn btn-primary btn-block header-like-btn" type="button">
<i class="fa fa-star"></i>&nbsp;
<!-- LikeBtn.com BEGIN -->
<span class="likebtn-wrapper" data-theme="nero" data-i18n_like="Like Dotto" data-white_label="true" data-identifier="%s" data-addthis_service_codes="twitter, facebook, linkedin, gmail, email, slack, telegram" data-show_like_label="false" data-dislike_enabled="false" data-counter_frmt="comma" data-popup_html="I like the Dotto!" data-share_size="large" data-site_id="604e13966fd08bbf03672c5b" data-i18n_like_tooltip="Like Dotto"></span>
<script>(function(d,e,s){if(d.getElementById("likebtn_wjs"))return;a=d.createElement(e);m=d.getElementsByTagName(e)[0];a.async=1;a.id="likebtn_wjs";a.src=s;m.parentNode.insertBefore(a, m)})(document,"script","//w.likebtn.com/js/w/widget.js");</script>
<!-- LikeBtn.com END -->
</button>
</div>
',
yaml::read_yaml(".yml")$dotto_id)

  # Authors ---------
  author_list <- metadata$author
  sub_col_4 <- rep(list(NA), length(author_list))
  for(i in 1:length(author_list)){
    sub_clo_4[[i]] <- sprintf('
<div class="col-1 d-flex flex-column mx-auto dotto-header-user">
<div class="row">
<div @click="%s = true" type="button"
class="col d-flex d-md-flex flex-row flex-shrink-1 justify-content-sm-end align-items-sm-center justify-content-md-end align-items-md-center dotto-header-user-icon">
<img class="img-fluid user-image border-warning %s" src="%s" />
</div>
</div>
<h6 class="d-flex justify-content-end dotto-header-user-name">
%s
</h6>
</div>
',
i,
(author_list[[i]])$lang,
(author_list[[i]])$img,
(author_list[[i]])$name)
  }

  col_4 <- paste(sub_clo_4, collapse = "\n")

  # Author Modals -----
  sub_modals <- rep(list(NA), length(author_list))
  for(i in 1:length(author_list)){
    sub_modals[[i]] <- sprintf('
<div v-if="%s" class="modal">
<!-- Modal content -->
<div class="modal-content">
<span @click="%s = false" class="close">&times;</span>
<div class="card" style="max-width: 540px">
<div class="row g-0">
<div class="col-md-4">
<img src="%s" class="img-fluid" />
</div>
<div class="col-md-8">
<div class="card-body">
<h5 class="card-title mb-0">%s</h5>
<p class="card-text mb-0">%s</p>
<p class="card-text mb-0">%s</p>
<p class="card-text">
<small class="text-muted">%s</small>
</p>
</div>
</div>
</div>
</div>
</div>
</div>
',
i,
i,
(author_list[[i]])$img,
(author_list[[i]])$name,
(author_list[[i]])$occupation,
(author_list[[i]])$affiliation,
(author_list[[i]])$url)
  }

  modals <- paste(sub_modals, collapse = "\n")

  return(sprintf(
    '
<section id="dotto-row-header">
<div class="row dotto-header">
%s
%s
%s
%s
</div>
</section>
%s
',
col_1,
col_2,
col_3,
col_4,
modals))

}



Dotto_sub_header <- function(metadata){

  sub_lang <- rep(list(NA), length(metadata$tech))

  for(i in 1:length(sub_lang)){
    sub_lang[[i]] <- sprintf('
<i type="button" @click="activeLang = \'%s\'"
class="%s"
:class="{\'%s\': activeLang === \'%s\'}">
</i>
',
(metadata$tech[[i]])$lang,
lang_icon_class((metadata$tech[[i]])$lang),
"text-warning",
(metadata$tech[[i]])$lang)
  }

  scol_1 <- sprintf('
<div class="col-4 d-flex flex-grow-0 justify-content-start align-items-center align-items-xl-center">
<div class="d-flex justify-content-around align-items-center bg-social-icons">
%s
</div>
</div>
', paste(sub_lang, collapse = "\n"))

  # -------

  scol_2 <- sprintf('
<div
class="col-8 d-flex justify-content-end align-items-center" style="padding-right: 15px">
<div class="d-flex justify-content-center align-items-center align-content-center bg-social-icons"
style="margin-right: 7px; width: 146.3px">
<span class="d-flex justify-content-lg-center align-items-lg-center" style="width: 133.7px">
<i class="fas fa-music" style="padding-right: 12px"> </i>
</span>
</div>
<div class="d-flex justify-content-around align-items-center bg-social-icons">
<i class="fa fa-linkedin-square"></i>
<i class="fab fa-twitter"></i>
</div>
<div class="text-nowrap d-flex justify-content-around align-items-center bg-social-icons bg-bugs-icons">
<i class="fab fa-github header-social-icon"></i>
<i class="fas fa-bug header-social-icon"></i>
</div>
</div>
')


  # -------

  return(sprintf('
<section>
<div id="dotto-row-info" class="d-flex">
%s
</div>
</section>
',
scol_1,
scol_2))

}

# Main Dotto part -------------

Dotto_main <- function(metadata, config_path) {
  config_path <- paste0(getwd(),"/.json")
  config <- jsonlite::fromJSON(config_path, simplifyDataFrame = T)

  index_chunks <- which(names(config) %in% "dots_chunks")
  meta <- config[-index_chunks]

  # ---------
  dots <- config[[index_chunks]] %>%
    dplyr::bind_rows() %>%
    tibble::tibble()

  num_lang <- dots %>%
    pull(lang) %>%
    unique() %>%
    length()

  num_dot <- dots %>%
    pull(dot) %>%
    unique() %>%
    length()

  # dot sidebar ---------
  scol <- rep(list(NA), num_dot)

  for(i in 1:length(scol)){
    scol[[i]] <- sprintf('
<button type="button" @click="activeMotto = \'%s\'"
class="btn dotto-main-dot-shape"
:class="{\'btn-light\': activeMotto === \'%s\', \'btn-outline-light\': activeMotto !== \'%s\'}">%s</button>
', i, i, i, i)

  }


  # dot contents --------
  dcol <- rep(list(NA), num_dot)

  for(i in 1:length(dcol)){

    # dot=i: `instruction` section for all langs -----------------
    sub_col_intro <- rep(list(NA), num_lang)
    for(l in (dots %>% pull(lang) %>% unique())){

      dot_intro <- dots %>%
        filter(dot == i, part == "instruction", lang == l) %>%
        pull(html_chunk)

      if(is.null(dot_intro)){
        dot_intro <- (dots %>%
                        filter(dot == i, part == "instruction") %>%
                        pull(html_chunk))[1]
      }

      sub_col_intro <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
%s
</div>
', l, dot_intro)

    }


    # dot=i: `code` section for all langs ------------------------
    sub_col_code <- rep(list(NA), num_lang)
    for(l in (dots %>% pull(lang) %>% unique())){

      dot_code <- dots %>%
        filter(dot == i, part == "code", lang == l) %>%
        pull(html_chunk)

      if(is.null(dot_code)){
        dot_code <- ""
      }

      sub_col_code <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
%s
</div>
',
l,
dot_code)

    }


    # dot=i: `result` section for all langs ---------------
    sub_col_result <- rep(list(NA), num_lang)
    for(l in (dots %>% pull(lang) %>% unique())){

      dot_result <- dots %>%
        filter(dot == i, part == "result", lang == l) %>%
        pull(html_chunk)

      if(is.null(dot_result)){
        dot_result <- ""
      }

      sub_col_result <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
%s
</div>
',
l,
dot_result)

    }





    # Create the full dot ----------------------------------------
    dcol[[i]] <- sprintf('
<div v-if="activeMotto === \'%s\'"
class="col-12 col-lg-11 d-flex p-0 wrapper">
%s
<div class="handler dotto-main-intro"></div>
<div id="resizable">
<div class="box2 dotto-main dotto-main-codes">
<h3>&nbsp; Codes</h3>
%s
</div>
<div class="handler2 dotto-main-output"></div>
<div class="box2 dotto-main dotto-main-output">
<h3>&nbsp;Outputs</h3>
%s
</div>
</div>
</div>
',
i,
paste(sub_col_intro, collapse = "\n"),
paste(sub_col_code, collapse = "\n"),
paste(sub_col_result, collapse = "\n"))

  }



  # ----------
  return(sprintf('
<section v-if="activeDotto === \'1\'"
class="text-left d-flex flex-row flex-grow-1 flex-wrap" id="dotto-row-main">
<div class="col-12 col-lg-1" id="dotto-main-dots">
%s
</div>
%s
</section>
',
paste(scol, collapse = "\n"),
paste(dcol, collapse = "\n")
  ))

}



# Single Dotto footer ---------
Dotto_footer <- function(metadata) {

  sprintf('
<section id="dotto-footer">
<div class="col-12 col-md-8">
<div class="d-flex" id="dotto-row-lines">
<i type="button" class="icon ion-ios-circle-filled d-sm-flex justify-content-sm-center dotto-lines-icons" >
</i>
</div>
</div>
<div class="col-12 col-md-4" id="dotto-comment" style="padding-top: 13px">
<div class="alert alert-danger dotto-alert-comment" role="alert">
%s
</div>
</div>
</section>
',
discus_dotto())

}



