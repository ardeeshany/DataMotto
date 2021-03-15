#' Render Dotto with more relax path and remove unnecessary libs
#'
#' @param path the path to the .Rmd file. If `NULL`, it automatically detect the .Rmd file in
#'   the current work directory (in case there is only one .Rmd file).
#'
#' @return
#' @export
#'
render_dotto <- function(path = NULL) {
  if(is.null(path)){
    path <- list.files(getwd(), pattern = "\\.Rmd$", full.names = T)
    if(length(path) > 1){
      stop("There is more than one .Rmd file in this path. Provide your file path in 'path'.")
    }
  }

  rmarkdown::render(input = path)

  return(invisible(NULL))
}
