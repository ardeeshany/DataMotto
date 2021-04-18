#' Create a config json variable based on each dots
#'
#' @description Each `Dot` will be evaluated and the html output will be saved as a separated object
#'   that can be sent to Dotto creation funtion.
#'
#' @details It first renders the Dotto in a simple `html_document` format and extract the html codes
#'   related to each chunk (`dot`). The output html code, attached with dot number, part, and language
#'   will be saved as a json object and will be passed to Dotto creation function for applying the style.
Config_Dotto_to_json <- function(){

  path <- "/Users/ardalanmirshani/rsites/DataMotto/posts/Dotto/D001-2021-04-04-analyzing-palmer-penguins-R/analyzing-palmer-penguins-R.Rmd"

  #rmarkdown::render(path)

  html_codes <- readLines(stringr::str_replace(path, pattern = "\\.Rmd", replacement = "\\.html")) %>%
    tibble() %>%
    rename("line" = ".") %>%
    mutate(start_dot = if_else(stringr::str_detect(lower_nospace(line), pattern = "^<!--dot:start;" ), T, F)) %>%
    mutate(dot = ifelse(start_dot, extract_pat(line, "dot_number:"), NA),
           part = ifelse(start_dot, extract_pat(line, "part:"), NA),
           lang = ifelse(start_dot, extract_pat(line, "lang:"), NA))

  text <- "<!--dot:start; Dot_number: 2, Part: result, Lang:python, ----"
  extract_pat <- function(text, pat) {
    text <- lower_nospace(text)
    stringr::str_extract(text, pattern = glue::glue("{pat}.*?,")) %>%
      stringr::str_remove_all(pattern = glue::glue("({pat})|(,)"))
  }

  list_of_dots <- split(html_codes, findInterval(1:nrow(html_codes), vec = html_codes %>% pull(start_dot) %>% which()))


  dots_chunks <- purrr::map_df(list_of_dots, function(x){
    if(x %>% pull(start_dot) %>% sum() != 0 ){
      html_chunk <- x %>%
        pull(line) %>%
        paste(collapse = "\n")

      x %>%
        select(-line) %>%
        filter(start_dot) %>%
        mutate(html_chunk = html_chunk) %>%
        select(-"start_dot")
    }
  })

  # ----
  meta_info <- rmarkdown::yaml_front_matter(path) %>%
    jsonlite::toJSON(auto_unbox = F,
                     pretty = T)

  config_json <- jsonlite::toJSON(dots_chunks,
                   auto_unbox = F,
                   pretty = T)

  return(config_json)

}

#' Convert an string to lowercase and remove white spaces
#' @family utility
#' @noRd
lower_nospace <- function(text) {
  stringr::str_replace_all(tolower(text), stringr::fixed(" "), "")
}
