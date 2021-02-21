#' Shared HTML template function
#' @export
default_template <- function(
  template_name,
  template_path,
  template_dependencies,
  pandoc_args,
  before_body,
  after_body,
  ...) {

  args <- list(...)
  ## For compatibility with pkgdown
  args$template <- NULL

  # code_folding <- args[["code_folding"]]
  # code_folding <- ifelse(is.null(code_folding), "none", code_folding)
  # code_download <- args[["code_download"]]
  # code_download <- ifelse(is.null(code_download), FALSE, code_download)
  # code_menu <- !identical(code_folding, "none") || code_download

  ## js and css dependencies
  extra_dependencies <- c(
    list(
      Dotto_dependency_jquery_slim(),
      Dotto_dependency_jquery(),
      Dotto_dependency_popper(),
      Dotto_dependency_bootstrap_js(),
      Dotto_dependency_bootstrap(),
      Dotto_dependency_font_awesome()
    ),
    template_dependencies
  )

  ## Merge "extra_dependencies"
  if ("extra_dependencies" %in% names(args)) {
    extra_dependencies <- append(extra_dependencies, args[["extra_dependencies"]])
    args[["extra_dependencies"]] <- NULL
    #args[["mathjax"]] <- NULL
  }

  # ## Force mathjax arguments
  # if (!is.null(args[["mathjax"]])) {
  #   pandoc_args <- c(pandoc_args,
  #                    "--mathjax",
  #                    "--variable", paste0("mathjax-url:", default_mathjax()))
  # }
  ## Other arguments
  pandoc_args <- c(pandoc_args,
                   "--variable", paste0(template_name, ":true"))
  if (args[["lightbox"]]) {
    pandoc_args <- c(pandoc_args, "--variable", "lightbox:true")
  }
  if (args[["thumbnails"]]) {
    pandoc_args <- c(pandoc_args, "--variable", "thumbnails:true")
  }

  ## Call rmarkdown::html_document
  html_document_args <- list(
    template = system.file(template_path, package = "DataMotto"),
    extra_dependencies = extra_dependencies,
    pandoc_args = pandoc_args,
    includes = list(before_body = before_body, after_body = after_body)
  )
  html_document_args <- append(html_document_args, args)

  do.call(rmarkdown::html_document, html_document_args)

}
