#' Create a valid slug from a text
#'
#' @description This function modify the text as follows:
#'   - change to lowecase
#'   - remove any characters outside a-z A-Z 0-9 and -
#'   - remove multile hyphens
#'   - trim hyphen from the start and end of text
#'   @note Idea from rstudio/distill
#' @export
create_slug <- function(title, slug = NULL) {

  if (is.null(slug))
    slug <- title


  slug %>%
    tolower() %>%
    stringr::str_replace(pattern = "\\s+", replacement = "-") %>%
    stringr::str_replace(pattern = "[^a-zA-Z0-9\\-]+", replacement = "-") %>%
    stringr::str_replace(pattern = "\\-{2,}", replacement = "-") %>%
    stringr::str_replace(pattern = "^-+", replacement = "-") %>%
    stringr::str_replace(pattern = "-+$", replacement = "-")


}


resolve_date_prefix <- function(date) {

  if (is.null(date))
    date <- Sys.Date()

  format(lubridate::as_date(date), "%Y/%m/%d")

}


#' Yes/No question in console
#' @param question the question will be appeared on the console.
#' @importFrom cli cli_alert_info
YN <- function(question) {
  cli::cli_alert_info(question)
  utils::menu(c("Yes", "No")) == 1
}



#' Create a folder if not exist
create_path_if_not_exist <- function(path){
  lets_create_path <- T
  if(dir.exists(path)){
    lets_create_path <- YN(glue::glue("{path} exists, override?"))
  }

  if(lets_create_path){
    suppressWarnings(suppressMessages(
      dir.create(path)
    ))
  }
}


#' Create a folder if not exist
create_file_if_not_exist <- function(path){
  lets_create_file <- T
  if(file.exists(path)){
    lets_create_file <- YN(glue::glue("{path} exists, override?"))
  }

  if(lets_create_file){
    suppressWarnings(suppressMessages(
      file.create(path)
    ))
  }
}

# Open a file in Rstudio (from Rstudio/distill)
open_file <- function(file, open = T) {
  if(open){
  if (rstudioapi::hasFun("navigateToFile"))
    rstudioapi::navigateToFile(file)
  else {
    utils::file.edit(file)
  }
  }
}



# Find an appropriate cover image
resolve_cover_image <- function(rmd_path, default_img_path = "resources/images/default_dotto.jpg") {

  cover_image <- rmarkdown::yaml_front_matter(rmd_path)$cover_image

  if(length(cover_image) > 1){
    stop("cover_image tag must be an string with length 1.")
  }

  rmd_name <- stringr::str_remove(basename(rmd_path), pattern = "\\.Rmd$")
  rmd_folder <- basename(dirname(rmd_path))
  image_path <- glue::glue("{dirname(rmd_path)}/{rmd_name}_files/figure-html")
  list_images <- list.files(image_path, full.names = F)

  if(is.null(cover_image)){
      selected_image <- default_img_path
  } else if((dirname(cover_image) == ".") && file.exists(glue::glue("{image_path}/{cover_image}"))) {
    selected_image <- glue::glue("./posts/Dotto/{rmd_folder}/{rmd_name}_files/figure-html/{cover_image}")
  } else if(tryCatch(httr::GET(cover_image),
                     error = function(e) list(status_code = 404))$status_code == 200){
    selected_image <- cover_image
  } else {
    selected_image <- default_img_path
  }

  return(selected_image)

}













