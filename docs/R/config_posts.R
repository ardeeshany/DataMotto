#' Config all posts
#'
#' @description It creates a `posts.json` file in the root the package with
#'  all the high level information (`metadata`) of posts.
#'
#'  @importFrom here here
#'  @import RJSONIO
#'  @import rmarkdown
#'  @importFrom glue glue
#' @export
config_posts <- function(path) {
  path_posts <- list.dirs(here::here("_posts"), recursive = F)
  all_metadata <- rep(list(NA), length(path_posts))
  for(i in 1:length(path_posts)){
    rmd_path <- glue::glue("{path_posts[i]}/{list.files(path = path_posts[i],pattern = '*.Rmd$')}")
    names(all_metadata)[i] <- gsub(pattern = "\\.Rmd$", "", basename(rmd_path))
    all_metadata[[i]] <- rmarkdown::yaml_front_matter(rmd_path)
  }

  exportJson <- RJSONIO::toJSON(all_metadata, asIs = T)
  write(exportJson, path)
}
