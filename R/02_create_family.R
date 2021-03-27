#' Create a `Dotto` family be generating a new `Dotto` based on another existing `Dotto`.
#'
#' @description It creates a template of `Dotto` based on an existing `Dotto` and we call them a family.
#'   The new `Dotto` automatically has a line connection to the base `Dotto` and the card generated in
#'   the index page combine the information related to all family.
#'
#' @param open If open the dotto file in Rstudio or not. Default is `TRUE`.
#' @importFrom here here
#' @importFrom glue glue
#' @export
create_family <- function(open = T) {

  all_rmds <- list.files(here::here("posts/Dotto"),
                         all.files = T, full.names = T,
                         recursive = T, pattern = "\\.Rmd$")

  selected_dotto_base <- all_rmds[1]

  dotto_yml_base <- rmarkdown::yaml_front_matter(selected_dotto_base)

# new yaml --------------------------
yaml <- sprintf(
'---
title: "%s"
description: %s
author:
  - name: "Your name"
    url: "https://YOUR_URL"
date: %s
techs:
  - lang: R
    pkg: [ggplot2, forcats]
  - lang: Python
    pkg: matplotlib
categories: [Visualization, Modeling]
cover_image:
slug: %s
output: DataMotto::Dotto
---', dotto_yml_base$title, date_prefix, slug)

}





