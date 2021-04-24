#' Update Dotto file and folder names based on updated `slug`
#'
#' @description The Dotto url is created based on the name on the Dotto folder, which
#'   follows the format `D#-date-slug`, e.g. `D112-2020-11-21-data-sampling`. As the Dotto
#'   file and folder names are created originally by `slug`, for changing the file/folder
#'   names, it is recommended to change `slug` first, and then run `update_Dotto()`.
#' @details for creating a valid `slug`, you can use `DataMotto::create_slug("foo")`
#'
#' @param path a path to the Dotto `.Rmd` file. IF the path is a rmd folder path, it automatically find the Rmd path
#'   if there is only one unique Rmd file in the folder.
#' @param clean_Dotto_deps Delete all the files and folders in Dotto and only keep .Rmd file. Default is `FALSE`.
#' @export
update_Dotto <- function(path = NULL, clean_dotto_deps = T){

  if(is.null(path)){
    res <- YN(question = paste0("Current path is ", getwd(), ", override?"))
    if(res){
      path <- getwd()
    } else {
      usethis::ui_done("Nothing is updated! Change the path and try again.")
      return(invisible(NULL))
    }
  }

  path <- here::here(path)

  if(!file.exists(path)){
    stop("Sorry, there is no file in the path!")
  }

  if(!stringr::str_detect(path, pattern = "\\.Rmd$")){
    path <- list.files(path, pattern = "\\.Rmd$", full.names = T)
    if(length(path) != 1){
      stop("There is no unique Rmd file in the path!")
    }
  }

  current_Dotto_name <- stringr::str_remove(basename(path), pattern = "\\.Rmd$")
  current_Dotto_folder <- basename(dirname(path))

  # new information ---------------------------------------
  Dotto_yaml <- rmarkdown::yaml_front_matter(path)
  new_Dotto_title <- Dotto_yaml$title
  new_Dotto_date <- format(as.Date(Dotto_yaml$date$created), "%Y-%m-%d")
  new_Dotto_slug <- Dotto_yaml$slug

  new_Dotto_name <- paste0(create_slug(new_Dotto_title, new_Dotto_slug))
  Dotto_label <- yaml::read_yaml(glue::glue("{dirname(path)}/.yml"))$dotto_label
  new_Dotto_folder <- paste0(Dotto_label, "-", new_Dotto_date, "-", new_Dotto_name)

  # check to update ---------------------------------------
  if(current_Dotto_name != new_Dotto_name | current_Dotto_folder != new_Dotto_folder) {

    # rename Dotto file name -----
    file.rename(from = path,
                to = glue::glue("{dirname(path)}/{new_Dotto_name}.Rmd"))
    usethis::ui_done(glue::glue("Dotto file is renamed to {new_Dotto_name}"))

    # rename Dotto folder name ------
    file.rename(from = dirname(path),
                to = glue::glue("{dirname(dirname(path))}/{new_Dotto_folder}"))
    usethis::ui_done(glue::glue("Dotto folder is renamed to {new_Dotto_folder}"))
    # -------------------------------
    if(clean_dotto_deps){
      new_path <- glue::glue("{dirname(dirname(path))}/{new_Dotto_folder}")
      all_files <- list.files(new_path, full.names = T)
      deleted_files <- stringr::str_subset(all_files, pattern = "\\.Rmd", negate = T)
      unlink(deleted_files, recursive = T)
      cat(cli::col_cyan("Your Dotto folder is clean now! Knit your Dotto agian."))
    } else {
      cat(cli::col_cyan("Don't forget to delete old html-file/deps, and then knit your Dotto again!"))
    }

  } else {
    usethis::ui_done("Dotto is already up-to-dated!")
  }



  return(invisible(NULL))


}
