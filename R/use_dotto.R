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
#' @export
#'
#'@examples
#'\dontrun{
#' DataMotto::use_dotto()
#'}
use_dotto <- function() {
  knitr::knit_hooks$set(Dot_title = function(before, options){
    if(before){
      paste(
        '<li class="nav-item">',
        sprintf('<a class="nav-link dm-dot-title">%s</a>', options$Dot_title),
        '<div class="dm-dot-content">',
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
