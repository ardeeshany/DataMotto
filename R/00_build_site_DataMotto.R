#' Build Data Motto Website
#'
#' @details It re-generate a `posts.json`, update the `index.html`, and create the whole
#'  website based on the updated `posts` folder.
#' @importFrom rmarkdown render_site
#' @importFrom here here
#' @importFrom usethis ui_done
#' @importFrom cli cat_rule
#' @export
build_site_DataMotto <- function() {

  cli::cat_rule("Site is being created")

  suppressWarnings(suppressMessages(
    rmarkdown::render_site(input = here::here() ,encoding = 'UTF-8', quiet = T)
  ))
  # rename all foo.html to index.html ----------------------
  list_all_htmls <- list.files(here::here("docs/posts/Dotto"),
                               pattern = "\\.html$",
                               full.names = T,
                               recursive = T)

  purrr::walk(list_all_htmls, ~ file.rename(.x, paste0(dirname(.x),"/","index.html")))

  # delete .Rmd files -------------------------------------
  list_all_rmds <- list.files(here::here("docs/posts/Dotto"),
                               pattern = "\\.Rmd$",
                               full.names = T,
                               recursive = T)

  purrr::walk(list_all_rmds, ~ file.remove(.x))

  # run static _foo.Rmd in the root path ------------------
  # run_root_rmds_if_needed(here::here())

  usethis::ui_done(glue::glue('Data Motto website is generated at "docs" folder.'))
}


#' Runs all `_` Rmd files in the root path of Data Motto if the updated date of html is behind.
#'
#'  @description This function compares the `_` Rmd and `html` created time. If the html time is behind,
#'    it runs the Rmd (and deleted the `_` from the beginning of the name).
run_root_rmds_if_needed <- function(path){

  all_special_rmds <- list.files(path = path, pattern = "(^_.*\\.Rmd$)", full.names = T)

  for(i in 1:length(all_special_rmds)){
    if((!file.exists(rmd_to_html(all_special_rmds[i]))) || (cr_time(all_special_rmds[i]) > cr_time(rmd_to_html(all_special_rmds[i])))) {
      suppressWarnings(suppressMessages(
        rmarkdown::render(input = all_special_rmds[i],
                          output_format = DataMotto::Index(),
                          output_file = basename(rmd_to_html(all_special_rmds[i])),
                          quiet = T)
      ))
      usethis::ui_done(glue::glue("Updating {basename(rmd_to_html(all_special_rmds[i]))}"))
    }
  }

  return(invisible(NULL))
}

#' Rename a Rmd file precedent with `_` to an html without the character.
#' @noRd
rmd_to_html <- function(path) {
  output_file <- basename(path) %>%
    stringr::str_remove(pattern = "^_") %>%
    stringr::str_replace(pattern = "\\.Rmd", replacement = "\\.html")

  output_path <- paste0(dirname(path),"/",output_file)
  return(output_path)
}

#' Returns a file created time
#' @noRd
cr_time <- function(path) {
  file.info(path)$ctime
}
