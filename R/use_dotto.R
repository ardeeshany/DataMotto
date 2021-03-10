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
  default_engines <- c("R", "python", "julia", "sql", "bash", "js", "node", "d3", "Rcpp", "stan")
  knitr::opts_chunk$set(Dot_title = NULL,
                        Dot_active = FALSE,
                        Dot_color = NULL,
                        Dot_open = T,
                        Dot_close = T)
  knitr::knit_hooks$set(Dot_title = function(before, options){
    if(before){
      if(options$Dot_open){
      if(is.null(options$Dot_color)){
      dot_col <- ifelse(options$engine %in% default_engines, options$engine, "others")
      } else {
      dot_col <- ifelse(options$Dot_color %in% default_engines, options$Dot_color, "others")
      }
      paste(
        '<li class="nav-item dot-li">',
        glue::glue('<a class="dot-li nav-link {ifelse(options$Dot_active, "active", "")} {paste0("dot-li-",{dot_col})} dm-dot-title"> {options$Dot_title} </a>'),
        glue::glue('<div class="dm-dot-content {ifelse(options$Dot_active, "active", "")}">'),
        sep = "\n"
      ) }
    } else {
      if(options$Dot_close){
      paste(
        '</div>',
        '</li>',
        sep = "\n"
      )}
    }
  })
}
