#' Create a new Dotto
#'
#' @description It creates a dotto based on a default `slug` created automatically based on title.
#'
#' @param title Title of the dotto post.
#' @param open If open the dotto file in Rstudio or not. Default is `TRUE`.
#' @importFrom here here
#' @importFrom glue glue
#' @export
create_Dotto <- function(title = NULL, open = T) {

  if(is.null(title)){
    stop('\n argument "title" is missing, with no default')
  }

  post_parent <- here::here("posts")
  date_prefix <- format(Sys.Date(), "%Y-%m-%d")
  slug <- resolve_slug(title = title, slug = NULL)
  dotto_folder_name <- paste0(date_prefix, "-", slug)
  dotto_file_name <- paste0(slug, ".Rmd")
  dotto_path <- glue::glue("{post_parent}/{dotto_folder_name}/{dotto_file_name}")

  create_path_if_not_exist(glue::glue("{post_parent}/{dotto_folder_name}"))
  create_file_if_not_exist(dotto_path)

# yaml --------------------------
yaml <- sprintf(
'---
title: "%s"
description: |
  A short description of the Dotto.
author:
  - name: "Your name"
    url: "https://YOUR_URL"
date: %s
tech: [R, Python]
packages: [pkg1, pkg2]
categories: [Visualization, Modeling]
preview: "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png"
cover_image_url: "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png"
slug: %s
output: DataMotto::Dotto
---', title, date_prefix, slug)

# body ---------------
body <-
'
<!--
Data Motto is a Multi-lingual Data Science Website.
Check Data Motto at <https://DataMotto.com>.
-->

```{r datamotto_dotto, echo=FALSE}
DataMotto::use_dotto()
```

<!-- Dot 1 ------------------------------------------------>

```{r, R-Dot, echo = T, Dot_title = "R", Dot_active = TRUE, Dot_open = T, Dot_close = T}
plot(cars)
```

'

con <- file(dotto_path, open = "w", encoding = "UTF-8")
on.exit(close(con), add = TRUE)
xfun::write_utf8(yaml, con)
xfun::write_utf8(body, con)

open_file(dotto_path)


}
