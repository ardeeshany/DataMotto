#' Create a config json file for an specific Dotto
#'
#' @description It creates the json file based on the Dotto yaml metadata and
#'   the `.yml` file, plus some customized site level information.
#' @family utility
#' @noRd
config_Dotto <- function(rmd_path) {

  file_name <- stringr::str_remove(basename(rmd_path), pattern = ".Rmd")
  dir_name <- basename(dirname(rmd_path))

  # identifiers from .yml -------
  list_ids_from_yml <- if(file.exists(paste0(dirname(rmd_path),"/.yml"))){
    yaml::read_yaml(paste0(dirname(rmd_path),"/.yml"))
  } else {
    list(dotto_id = NULL)
  }
  # all metadata ----------------
  Dotto_metadata <- rmarkdown::yaml_front_matter(rmd_path)
  for(i in 1:length(Dotto_metadata$author)){

    img_path <- resolve_author_img(rmd_path = rmd_path,
                                   img_path = (Dotto_metadata$author[[i]])$img)

    Dotto_metadata$author[[i]] <- c(Dotto_metadata$author[[i]],
                                    list("profile_img_for_Dotto" = img_path,
                                         "profile_img" = paste0("./posts/Dotto/",
                                                                dir_name,
                                                                stringr::str_remove(img_path, pattern = "^.")))
                                    )
  }
  return(c(list(file_name = file_name,
                dir_name = dir_name,
                cover_image_url = resolve_cover_image(rmd_path),
                link = glue::glue("posts/Dotto/{dir_name}/index.html"),
                base_url = rmarkdown::site_config(here::here())$base_url,
                social_networks_datamotto = rmarkdown::site_config(here::here())$social_networks),
           list_ids_from_yml,
           Dotto_metadata))
}


#' Create a site config file
#'
#' @description It generates a `Motto.js` file that comprises all Dotto config files
#'   and save it in the `assets` folder.
#' @noRd
build_site_config <- function() {
  path_all_jsons <- list.files(here::here("posts/Dotto"),
                               all.files = T,  full.names = T,
                               recursive = T, pattern = ".json$")
  all_jsons <- rep(list(NA), length(path_all_jsons))
  names(all_jsons) <- basename(dirname(path_all_jsons))
  for(i in 1:length(path_all_jsons)){
    all_jsons[[i]] <- jsonlite::fromJSON(txt = path_all_jsons[i])
  }

  Mottojs <- sprintf(
'export default %s
', jsonlite::toJSON(all_jsons, auto_unbox = F, pretty = T))

  con <- file(here::here("assets/mottos.js"), open = "w", encoding = "UTF-8")
  xfun::write_utf8(Mottojs, con)
  close(con)

}


#' Create a config json variable based on each dots
#'
#' @description Each `Dot` will be evaluated and the html output will be saved as a separated object
#'   that can be sent to Dotto creation funtion.
#'
#' @details It first renders the Dotto in a simple `html_document` format and extract the html codes
#'   related to each chunk (`dot`). The output html code, attached with dot number, part, and language
#'   will be saved as a json object and will be passed to Dotto creation function for applying the style.
Config_Dotto_to_json <- function(path){

  if(TRUE){
    usethis::ui_warn("'Config_Dotto_to_json' is deprecated.
                     Please check 'DataMotto::config_Dotto()'.")
    return(invisible(NULL))
  }

  html_codes <- readLines(list.files(path, pattern = "\\.html$", full.names = T)) %>%
    tibble() %>%
    rename("line" = ".") %>%
    mutate(start_dot = ifelse(stringr::str_detect(lower_nospace(line), pattern = "^<!--dot-start;" ), T, F)) %>%
    mutate(dot = ifelse(start_dot, extract_pat(line, "dot:"), NA),
           part = ifelse(start_dot, extract_pat(line, "part:"), NA),
           lang = ifelse(start_dot, extract_pat(line, "lang:"), NA))

  list_of_dots <- split(html_codes, findInterval(1:nrow(html_codes), vec = html_codes %>% pull(start_dot) %>% which()))


  dots_chunks <- purrr::map(list_of_dots, function(x){
    if(x %>% pull(start_dot) %>% sum() != 0 ){
      start_end_ind <- x %>%
        pull(line) %>%
        stringr::str_detect(pattern = "(<!--dot-start)|(<!--dot-end)") %>%
        which()

      if(length(start_end_ind) == 2){
        html_chunk <- x %>%
          slice(start_end_ind[1]:start_end_ind[2]) %>%
          pull(line) %>%
          paste(collapse = "\n")

        x %>%
          select(-line) %>%
          filter(start_dot) %>%
          mutate(html_chunk = html_chunk) %>%
          select(-"start_dot")
      }
    }
  }) %>% purrr::keep( ~ !is.null(.) )

  # ----
  config_json <- c(config_Dotto(list.files(getwd(), pattern = "\\.Rmd$", full.names = T)),
                   list("dots_chunks" = dots_chunks)) %>%
    jsonlite::toJSON(auto_unbox = F,
                     pretty = T)

  return(config_json)

}



# Utilities ----------------------------------------------------------------------

#' Convert a string to lowercase and remove white spaces
#' @family utility
#' @noRd
lower_nospace <- function(text) {
  stringr::str_replace_all(tolower(text), stringr::fixed(" "), "")
}

#' Extract Pattern
#'
#' @description To indentify the Dot number, Dot part, and Dot lang from the
#'   html special comment.
#' @family utility
#' @noRd
extract_pat <- function(text, pat) {
  text <- lower_nospace(text)
  stringr::str_extract(text, pattern = glue::glue("{pat}.*?,")) %>%
    stringr::str_remove_all(pattern = glue::glue("({pat})|(,)"))
}
