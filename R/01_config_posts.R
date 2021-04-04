#' Config all posts (Dottos)
#'
#' @description It creates a `posts.json` file in the root the package with
#'  all the high level information (`metadata`) of posts.
#'
#'  @param title_width numeric. The maximum width of title shows in the card of index page. Default is `50` characters.
#'  @param desc_width numeric. The maximum width of description shows in the card of index page. Default is `150` characters.
#'  @importFrom here here
#'  @importFrom jsonlite toJSON
#'  @import rmarkdown
#'  @importFrom glue glue
#' @export
config_posts <- function(title_width = 50, desc_width = 150) {
  path_posts <- list.dirs(here::here("posts/Dotto"), recursive = F)
  all_metadata <- rep(list(NA), length(path_posts))
  for(i in 1:length(path_posts)){
    rmd_path <- glue::glue("{path_posts[i]}/{list.files(path = path_posts[i],pattern = '*.Rmd$')}")
    file_name <- stringr::str_remove(basename(rmd_path), pattern = ".Rmd")
    dir_name <- basename(dirname(rmd_path))
    # rmd's yml --------------------
    cover_image_url <- resolve_cover_image(rmd_path)
    lang <- purrr::map_chr(rmarkdown::yaml_front_matter(rmd_path)$techs, ~ .x$lang) %>% tolower()
    names(all_metadata)[i] <- gsub(pattern = "\\.Rmd$", "", basename(rmd_path))
    title_on_cards <- stringr::str_trunc(rmarkdown::yaml_front_matter(rmd_path)$title, width = title_width)
    desc_on_cards <- stringr::str_trunc(rmarkdown::yaml_front_matter(rmd_path)$description, width = desc_width)
    # identifiers from .yml -------
    list_ids_from_yml <- if(file.exists(paste0(dirname(rmd_path),"/.yml"))){
                            yaml::read_yaml(paste0(dirname(rmd_path),"/.yml"))
      } else {
        list(dotto_id = NULL)
        }


    # output ----------------------
    all_metadata[[i]] <- c(rmarkdown::yaml_front_matter(rmd_path),
                           list(title_on_cards = title_on_cards,
                                desc_on_cards = desc_on_cards),
                           list(base_url = rmarkdown::site_config(here::here())$base_url,
                                twitter_site = rmarkdown::site_config(here::here())$twitter$site),
                           list(file_name = file_name,
                                dir_name = dir_name,
                                cover_image_url = cover_image_url,
                                tech = lang,
                                link = glue::glue("./posts/Dotto/{dir_name}/index.html")),
                           list_ids_from_yml
                           )
  }

  return(all_metadata)
}
