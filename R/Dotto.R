#' Convert to a Dotto template
#'
#' Format for converting from R Markdown to an HTML document.
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
#' @import bookdown
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
                       in_header = NULL,
                       before_body = here::here("./resources/header_post.html"),
                       after_body = here::here("./resources/footer.html"),
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
                            src = system.file("templates/Dotto", package = "DataMotto"),
                            head = list(paste0(
                              '<link rel="shortcut icon" href="../../',rmarkdown::site_config(input = here::here())$favicon,'">'
                            )),
                            script = c("Dotto.js", "Dotto_firebase.js"),
                            stylesheet = "Dotto.css")
}
