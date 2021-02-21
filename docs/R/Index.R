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
Index <- function(fig_width = 6,
                       fig_height = 6,
                       fig_caption = TRUE,
                       highlight = "kate",
                       lightbox = TRUE,
                       thumbnails = TRUE,
                       pandoc_args = NULL,
                       md_extensions = "-autolink_bare_uris",
                       self_contained = FALSE,
                       before_body = "./resources/header.html",
                       after_body = "./resources/footer.html",
                       ...) {
  default_template(
    template_name = "Index_page",
    template_path = "templates/Index_page.html",
    template_dependencies = list(
      Index_page_dependency()
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
    before_body = before_body,
    after_body = after_body,
    # mathjax = mathjax,
    ...
  )
}

# dotto js and css
Index_page_dependency <- function() {
  htmltools::htmlDependency(name = "Index_page",
                            version = "0.1.0",
                            src = system.file("templates/Index_page", package = "DataMotto"),
                            script = "Index_page.js",
                            stylesheet = "Index_page.css")
}

# Dependency added manually (not from a library)
Index_page_dependency <- function() {
  htmltools::htmlDependency(name = "Index_page",
                            version = "0.1.0",
                            src = system.file("templates/Index_page", package = "DataMotto"),
                            head = paste0(
                              "<script> var json =",
                              jsonlite::toJSON(config_posts(),
                                               auto_unbox = F,
                                               pretty = TRUE),
                              "</script>"
                            ),
                            script = "Index_page.js",
                            stylesheet = "Index_page.css")
}

