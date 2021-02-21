#' Build Data Motto Website
#'
#' @details It re-generate a `posts.json`, update the `index.html`, and create the whole
#'  website based on the updated `posts` folder.
#' @importFrom rmarkdown render_site
#' @importFrom here here
#' @importFrom usethis ui_done
#' @export
build_data_motto <- function() {
  config_posts(path = here::here("posts.json"))
  rmarkdown::render_site(encoding = 'UTF-8', quiet = T)
  usethis::ui_done("Site is generated at 'docs' folder.")
}
