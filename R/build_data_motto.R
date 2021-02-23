#' Build Data Motto Website
#'
#' @details It re-generate a `posts.json`, update the `index.html`, and create the whole
#'  website based on the updated `posts` folder.
#' @importFrom rmarkdown render_site
#' @importFrom here here
#' @importFrom usethis ui_done
#' @importFrom cli cat_rule
#' @export
build_data_motto <- function() {

  cli::cat_rule("Site is being created")
  suppressWarnings(suppressMessages(
    rmarkdown::render_site(encoding = 'UTF-8', quiet = T)
  ))
  usethis::ui_done(glue::glue('Data Motto website is generated at {usethis::ui_path("docs")} folder.'))
}
