#' Create the Index page of DataMotto.com
#'
#' Format for converting from R Markdown to an HTML document.
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
Index <- function(fig_width = 6,
                       fig_height = 6,
                       fig_caption = TRUE,
                       highlight = "kate",
                       lightbox = TRUE,
                       thumbnails = TRUE,
                       pandoc_args = NULL,
                       md_extensions = "-autolink_bare_uris",
                       self_contained = F,
                       in_header = NULL,
                       before_body = here::here("./resources/header.html"),
                       after_body = NULL,
                       #after_body = here::here("./resources/footer.html"),
                       ...) {

  html_document(#template = system.file("templates/Dotto.html", package = "DataMotto"),
    template = here::here("inst/templates/Index_page.html"),
    includes = list(in_header = in_header,
                    before_body = before_body,
                    after_body = after_body),
    highlight = highlight,
    mathjax = mathjax,
    self_contained = self_contained)

  # default_template(
  #   template_name = "Index_page",
  #   template_path = "templates/Index_page.html",
  #   template_dependencies = list(
  #     Index_page_dependency()
  #   ),
  #   pandoc_args = pandoc_args,
  #   fig_width = fig_width,
  #   fig_height = fig_height,
  #   fig_caption = fig_caption,
  #   highlight = highlight,
  #   lightbox = lightbox,
  #   thumbnails = thumbnails,
  #   md_extensions = md_extensions,
  #   self_contained = self_contained,
  #   in_header = in_header,
  #   before_body = before_body,
  #   after_body = after_body,
  #   # mathjax = mathjax,
  #   ...
  # )
}


# Dependency added manually (not from a library)
# Index_page_dependency <- function() {
#   htmltools::htmlDependency(name = "Index_page",
#                             version = "0.1.0",
#                             src = system.file("templates/DataMotto", package = "DataMotto"),
#                             head = list(paste0(
#                               # "<script> var likebtn =",
#                               # jsonlite::toJSON(get_likebtn(),
#                               #                  auto_unbox = F,
#                               #                  pretty = T),
#                               # "</script>",
#                               "<script> var json =",
#                               jsonlite::toJSON(config_posts(),
#                                                auto_unbox = F,
#                                                pretty = T),
#                               "</script>",
#                               '<link rel="shortcut icon" href="',rmarkdown::site_config(input = here::here())$favicon,'">'
#                               )),
#                             script = "Index_page.js",
#                             stylesheet = "site.css",
#                             all_files = F)
# }



#' GET like numbers from LikeBtn API
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
# get_likebtn <- function() {
#   likebtn_url <- "https://api.likebtn.com/api/?action=stat&email=ardeeshany@gmail.com&api_key=d3c37a0cc65e905b9128141de89253db&site_id=604e13966fd08bbf03672c5b&output=json&sort=likes"
#   likebtn_json <- httr::GET(likebtn_url)
#   jsonlite::fromJSON(content(likebtn_json, "text"),simplifyDataFrame = T)
# }
