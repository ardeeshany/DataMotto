resolve_slug <- function(title, slug) {

  if (is.null(slug))
    slug <- title

  # from Rstudio/distill
  slug <- tolower(slug)                        # convert to lowercase
  slug <- gsub("\\s+", "-", slug)              # replace spaces with -
  slug <- gsub("[^a-zA-Z0-9\\-]+", "", slug)   # remove all non-word chars
  slug <- gsub("\\-{2,}", "-", slug)           # replace multiple - with single -
  slug <- gsub("^-+", "", slug)                # trim - from start of text
  slug <- gsub("-+$", "", slug)                # trim - from end of text

  slug

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
    lets_create_path <- YN(glue::glue("{path} exists, override?"), path)
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
    lets_create_file <- YN(glue::glue("{path} exists, override?"), path)
  }

  if(lets_create_file){
    suppressWarnings(suppressMessages(
      file.create(path)
    ))
  }
}

# Open a file in Rstudio (from Rstudio/distill)
open_file <- function(file) {
  if (rstudioapi::hasFun("navigateToFile"))
    rstudioapi::navigateToFile(file)
  else {
    utils::file.edit(file)
  }
}
