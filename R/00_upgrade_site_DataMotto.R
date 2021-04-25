#' Upgrading Website by adding a new Dotto
#'
#' @description It renders the new Dotto and adds it into the Data Motto, which was already created
#'   and then renders `Index.Rmd` to upgrade the cards in the main page.
#' @param path The path into the Dotto `.Rmd`. If the path directs to the Dotto folder
#'   and there exists only one `.Rmd` there, it automatically update the path to
#'   select the Dotto Rmd file. Default is `NULL` that selects the current working directory.
#' @param keep_original_site_libs a logical value that keeps the original `site_libs` folder, created by \link[build_site_DataMotto]
#'   rather than adding a new `site_libs` created by rendering `Index.Rmd`. Default is `TRUE`.
#' @param open A logical value that opens the Index page of site in the browser. Default is `TRUE`.
#' @importFrom fs dir_copy dir_delete
#' @importFrom here here
#' @export
#'
upgrade_site_DataMotto <- function(path = NULL, keep_original_site_libs = T, open = T) {

  if(is.null(path)){
    path <- list.files(getwd(), pattern = "\\.Rmd$", full.names = T)
    if(length(path) > 1){
      stop("There is more than one .Rmd file in this path. Provide a file path in 'path'.")
    }
  }

  folder_name <- basename(dirname(path))
  fs::dir_copy(path = dirname(path),
               new_path = paste0(here::here("docs/posts/Dotto/"), folder_name),
               overwrite = T)

  # rename *.html to index.html
  html_file <- list.files(paste0(here::here("docs/posts/Dotto/"),folder_name),
                          full.names = T,
                          pattern = "\\.html$")

  file.rename(from = html_file,
              to = paste0(here::here("docs/posts/Dotto/"),folder_name, "/index.html"))

  # delete .Rmd files -------------------------------------
  list_all_rmds <- list.files(paste0(here::here("docs/posts/Dotto/"),folder_name),
                              pattern = "\\.Rmd$",
                              full.names = T,
                              recursive = T)
  file.remove(list_all_rmds)

  if(keep_original_site_libs){
  usethis::ui_done("The Dotto is added into docs/posts/Dotto")
  }
  # render index.Rmd page ===============
  file.rename(from = here::here("docs/site_libs"), to = here::here("docs/site_libs_temp"))
  rmarkdown::render(input = here::here("Index.Rmd"),
                    output_format = DataMotto::Index(lib_dir = "docs/site_libs"),
                    output_file = "index.html",
                    quiet = T,
                    output_dir = here::here("docs"))

  if(keep_original_site_libs){
  fs::dir_delete(here::here("docs/site_libs"))
  file.rename(from = here::here("docs/site_libs_temp"), to = here::here("docs/site_libs"))
  }

  if(TRUE){ # copy site_libs into root folder for dev purposes
    file.copy(from = here::here("docs/site_libs"),
              to = here::here(""),
              recursive = T,
              overwrite = T)
  }

  usethis::ui_done(glue::glue("Index page is rendered and the site is ready at {usethis::ui_path('docs')}."))

  if(open){
    browseURL(here::here("docs/Index.html"))
  }

}
