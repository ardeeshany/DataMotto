#' Config all posts
#'
#' @description It creates a `posts.json` file in the root the package with
#'  all the high level information (`metadata`) of posts.
#'
#'  @importFrom here here
#'  @importFrom jsonlite toJSON
#'  @import rmarkdown
#'  @importFrom glue glue
#' @export
config_posts <- function(path) {
  path_posts <- list.dirs(here::here("posts"), recursive = F)
  all_metadata <- rep(list(NA), length(path_posts))
  for(i in 1:length(path_posts)){
    rmd_path <- glue::glue("{path_posts[i]}/{list.files(path = path_posts[i],pattern = '*.Rmd$')}")
    file_name <- stringr::str_remove(basename(rmd_path), pattern = ".Rmd")
    dir_name <- basename(dirname(rmd_path))
    post_slug <- ifelse(is.null(rmarkdown::yaml_front_matter(rmd_path)$slug), file_name, rmarkdown::yaml_front_matter(rmd_path)$slug)
    names(all_metadata)[i] <- gsub(pattern = "\\.Rmd$", "", basename(rmd_path))
    all_metadata[[i]] <- c(rmarkdown::yaml_front_matter(rmd_path),
                           list(base_url = rmarkdown::site_config(here::here())$base_url,
                                twitter_site = rmarkdown::site_config(here::here())$twitter$site),
                           list(file_name = file_name,
                                dir_name = dir_name,
                                post_slug = post_slug,
                                link = glue::glue("./posts/{dir_name}/{post_slug}.html"))
                           )
  }

  return(all_metadata)
  # exportJson <- jsonlite::toJSON(all_metadata,
  #                                auto_unbox = TRUE,
  #                                pretty = TRUE)
  # write(exportJson, path)
}
