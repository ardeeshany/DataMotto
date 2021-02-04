create_new_listing <- function(title = "My title", subfolder = "Gallery"){
  override <- T
  if(file.exists(here::here(paste0(subfolder, ".Rmd")))){
    usethis::ui_info("File exists, override?")
    override <- utils::menu(choices = c("Yes", "No")) == 1
  }
  if(override){
    write_yml <- function(what){
      write(what, file = here::here(glue::glue("{subfolder}.Rmd")), append = TRUE)
    }

    file.create(here::here(paste0(subfolder, ".Rmd")))

    write_yml("---")
    write_yml(glue::glue("title: {title}"))
    write_yml("site: distill::distill_website")
    write_yml("listing:")
    write_yml("  posts:")
    purrr::walk(
      list.dirs(here::here(glue::glue("_posts/{subfolder}")), full.names = F, recursive = F),
      function(.x){ write_yml(paste0('   - ',subfolder, '/', .x)); cat('\n')}
    )
    write_yml("---")
  } else {
    usethis::ui_oops("Your file has not been touched!")
  }
}
