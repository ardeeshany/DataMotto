#' Dotto extensions
#'
#' Adds required extensions that are necessary for setting up
#' Rmd file gets `Dotto` style.
#'
#' @details Add the following code chunk to your Rmarkdown file with output \code{DataMotto::Dotto}.
#'   \code{```{r datamotto_dotto, echo=FALSE}
#'         DataMotto::use_Dotto()
#'         ```}
#' @importFrom htmltools HTML
#' @importFrom knitr knit_hooks
#' @importFrom glue glue
#' @export
#'
#'@examples
#'\dontrun{
#' DataMotto::use_Dotto()
#'}
use_Dotto <- function() {

  #default_engines <- c("R", "python", "julia", "sql", "bash", "js", "node", "d3", "Rcpp", "stan")

  # knitr::opts_chunk$set(Dot_title = NULL,
  #                       Dot_active = FALSE,
  #                       Dot_color = NULL,
  #                       Dot_open = T,
  #                       Dot_close = T)

  rmd_path <- list.files(getwd(), pattern = "\\.Rmd$", full.names = T)
  metadata <- config_Dotto(rmd_path) %>%
    jsonlite::toJSON(auto_unbox = F,
                     pretty = T)
  con <- file(".json", open = "w", encoding = "UTF-8")
  xfun::write_utf8(text = metadata, con = con)
  close(con)
  meta <- jsonlite::fromJSON(".json", simplifyDataFrame = T)

  num_dot <- stringr::str_subset(lower_nospace(readLines(rmd_path)), pattern = "^```\\{.*dot.*") %>%
    stringr::str_extract(pattern = "(?<=dot=).") %>%
    max()

  scol <- rep(list(NA), num_dot)

  for(i in 1:length(scol)){
    scol[[i]] <- sprintf('
<button type="button" @click="activeMotto = \'%s\'"
class="btn dotto-main-dot-shape"
:class="{\'btn-light\': activeMotto === \'%s\', \'btn-outline-light\': activeMotto !== \'%s\'}">%s</button>
', i, i, i, i)

  }

  first_lang <- head(meta$tech$lang, n = 1)[[1]]
  last_lang <-  tail(meta$tech$lang, n = 1)[[1]]


knitr::knit_hooks$set(Dot = function(before, options){

if(before){

x1 <- "\n"
x2 <- "\n"
if(tolower(options$part) == "instruction"){
if(tolower(options$lang) == tolower(first_lang)){
x1 <- sprintf('
<div v-if="activeMotto === \'%s\'" class="col-12 col-lg-11 d-flex p-0 wrapper">
<div class="box dotto-main-intro">
<h3>&nbsp;Instructions:</h3>
', options$Dot)
}

x2 <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
<p class="mx-2">
',
tolower(options$lang))
}

if(tolower(options$part) == "code"){

if(tolower(options$engine) == tolower(first_lang)){
x1 <- sprintf('
</div>
<div class="handler dotto-main-intro"></div>
<div id="resizable">
<div class="box2 dotto-main dotto-main-codes">
<h3>&nbsp; Codes:</h3>
')
}

x2 <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
',
tolower(options$engine))
}

if(tolower(options$part) == "result"){

if(tolower(options$engine) == tolower(first_lang)){
x1 <- sprintf('
</div>
<div class="handler2 dotto-main-output"></div>
<div class="box2 dotto-main dotto-main-output">
<h3>&nbsp;Results:</h3>
')
}

x2 <- sprintf('
<div v-if="activeLang === \'%s\'" class="mx-2">
',
tolower(options$engine))
}

knitr::asis_output(htmltools::htmlPreserve(paste(x1, x2, collapse = "\n")))

} else {

x1 <- "\n"
x2 <- "\n"
if(tolower(options$part) == "instruction"){
x1 <- sprintf('
</p>
</div>
')
}

if(tolower(options$part) == "code"){
x1 <- sprintf('
</div>
')
}

if(tolower(options$part) == "result"){
x1 <- sprintf('
</div>
')

if(tolower(options$engine) == tolower(last_lang)){
x2 <- sprintf('
</div>
</div>
</div>
')
}
}
knitr::asis_output(htmltools::htmlPreserve(paste(x1, x2, collapse = "\n")))
}
  }

)

knitr::asis_output(htmltools::htmlPreserve(sprintf('
<section v-if="activeDotto === \'1\'"
class="text-left d-flex flex-row flex-grow-1 flex-wrap" id="dotto-row-main">
<div class="col-12 col-lg-1" id="dotto-main-dots">
%s
</div>
', paste(scol, collapse = "\n"))))

}




#' Add banner card on top of Dotto
#'
#' @description This includes the meta information related the Dotto, such as title,
#'   description, date, authors, etc.
#' @noRd
Dotto_banner <- function(metadata){

# title and description -------------------------------
col_1 <- sprintf('
<div class="row">
<div class="col-md-6">
<h2>%s</h2>
<p>%s</p>
</div>
', metadata$title, metadata$description)

# categories -------------------------------
col_2 <- sprintf('
<div class="col-md-2">
<div class="row">
%s
</div>
</div>
',dotto_categories(metadata))

# techs ------------------------------------

col_3 <- sprintf('
<div class="col-md-2">
<div class="row">
%s
</div>
</div>
',dotto_techs(metadata))



# date and author ------------------------------------
col_4 <- sprintf('
<div class="col-md-2">
<div class="dm-posts-desc">
<div class="row pt-1">
%s
</div>
<div class="row">
<span> <i class="far fa-clock" class="pr-1"></i> %s </span>
</div>
<!-- LikeBtn.com BEGIN -->
<span class="likebtn-wrapper" data-theme="nero" data-i18n_like="Like Dotto" data-white_label="true" data-identifier="%s" data-addthis_service_codes="twitter, facebook, linkedin, gmail, email, slack, telegram" data-show_like_label="false" data-dislike_enabled="false" data-counter_frmt="comma" data-popup_html="I like the Dotto!" data-share_size="large" data-site_id="604e13966fd08bbf03672c5b" data-i18n_like_tooltip="Like Dotto"></span>
<script>(function(d,e,s){if(d.getElementById("likebtn_wjs"))return;a=d.createElement(e);m=d.getElementsByTagName(e)[0];a.async=1;a.id="likebtn_wjs";a.src=s;m.parentNode.insertBefore(a, m)})(document,"script","//w.likebtn.com/js/w/widget.js");</script>
<!-- LikeBtn.com END -->
</div>
</div>
', dotto_authors(metadata), metadata$date, yaml::read_yaml(".yml")$dotto_id)

return(sprintf(
'
%s
%s
%s
%s
</div>
<ul class="nav nav-tabs">
', col_1, col_2, col_3, col_4))

}

#' Extract category information in HTML format
#' @noRd
dotto_authors <- function(metadata){
  vec <- rep(NA, length(metadata$author))
  for(i in 1:length(metadata$author)){
    vec[i] <- sprintf('
<span style="margin-right: .75em;"> <i class="far fa-user"></i> <a href=%s target="_blank"> %s</a></span>
', metadata$author[[i]]$url %>% resolve_url(), metadata$author[[i]]$name)
  }
  return(paste0(vec, collapse = ""))
}


#' Extract categories in HTML format
#' @noRd
dotto_categories <- function(metadata){
  vec <- rep(NA, length(metadata$categories))
  for(i in 1:length(metadata$categories)){
    vec[i] <- sprintf('
<span class="badge badge-pill badge-info mr-1" style="font-size:11px; background:#1d9b9f;">%s</span>
', metadata$categories[i])
  }
  return(paste0(vec, collapse = ""))
}


#' Extract tech information in HTML format
#' @import dplyr
dotto_techs <- function(metadata){
  vec <- rep(NA, length(metadata$techs))
  for(i in 1:length(metadata$techs)){
    vec[i] <- sprintf('
<div class="dm-dot-icon %s-color mr-1" title="%s">%s</div>
', metadata$techs[[i]]$lang %>% tolower(),
                      metadata$techs[[i]]$lang %>% toupper(),
                      tech_html_icon(metadata$techs[[i]]$lang %>% tolower()))
  }
  return(paste0(vec, collapse = ""))
}

# engine icons -----------------------
tech_html_icon <- function(lang, full_name = F) {
  if(tolower(lang) == "r"){
    icon <- '<i class="fab fa-r-project"></i>'
  } else if(tolower(lang) == "python"){
    icon <- '<i class="fab fa-python"></i>'
  } else if(tolower(lang) == "julia"){
    # icon <- ifelse(full_name, 'Julia', 'Jul')
    icon <- '<i class="icon-julialang-icon"><i class="path1"></i><i class="path2"></i><i class="path3"></i></i>'
  } else if(tolower(lang) == "sql"){
    icon <- '<i class="icon-file-sql"></i>'
  } else if(tolower(lang) == "rcpp"){
    icon <- ifelse(full_name, 'Rcpp', 'Rc')
  } else if(tolower(lang) == "node"){
    icon <- '<i class="fab fa-node-js"></i>'
  } else if(tolower(lang) == "bash"){
    icon <- '<i class="fas fa-terminal"></i>'
  } else if(tolower(lang) == "js"){
    icon <- '<i class="icon-javascript"></i>'
  } else if(tolower(lang) == "d3"){
    icon <- '<i class="icon-d3-dot-js"></i>'
  } else if(tolower(lang) == "stan"){
    icon <- ifelse(full_name, 'Stan', 'St')
  } else {
    icon <- lang
  }
  return(icon)
}


lang_icon_class <- function(lang, full_name = F) {
  if(tolower(lang) == "r"){
    icon <- "fab fa-r-project"
  } else if(tolower(lang) == "python"){
    icon <- "fab fa-python"
  } else if(tolower(lang) == "sql"){
    icon <- "icon-file-sql"
  }
  return(icon)
}

#' Resolve url with embedding a valid schema
#' @importFrom urltools url_parse
resolve_url <- function(url){
  if(is.null(url)) {
    return("")
  } else{
    url_p <- urltools::url_parse(url)

    if(is.na(url_p['scheme'] %>% as.character())){
      return(paste0("https://", url))
    } else {
      return(url)
    }
  }
}

