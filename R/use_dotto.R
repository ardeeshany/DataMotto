#' Dotto extensions
#'
#' Adds required extensions that are necessary for setting up
#' Rmd file gets `Dotto` style.
#'
#' @details Add the following code chunk to your Rmarkdown file with output \code{DataMotto::Dotto}.
#'   \code{```{r datamotto_dotto, echo=FALSE}
#'         DataMotto::use_dotto()
#'         ```}
#' @importFrom htmltools HTML
#' @importFrom knitr knit_hooks
#' @importFrom glue glue
#' @export
#'
#'@examples
#'\dontrun{
#' DataMotto::use_dotto()
#'}
use_dotto <- function() {
  knitr::opts_chunk$set(Dot_active = FALSE)
  knitr::knit_hooks$set(Dot_title = function(before, options){
    if(before){
      paste(
        '<li class="nav-item">',
        glue::glue('<a class="nav-link {ifelse(options$Dot_active, "active", "")} dm-dot-title"> {options$Dot_title} </a>'),
        glue::glue('<div class="dm-dot-content {ifelse(options$Dot_active, "active", "")}">'),
        sep = "\n"
      )
    } else {
      paste(
        '</div>',
        '</li>',
        sep = "\n"
      )
    }
  })
}
