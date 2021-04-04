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
use_Dotto <- function(metadata) {

  default_engines <- c("R", "python", "julia", "sql", "bash", "js", "node", "d3", "Rcpp", "stan")

  knitr::opts_chunk$set(Dot_title = NULL,
                        Dot_active = FALSE,
                        Dot_color = NULL,
                        Dot_open = T,
                        Dot_close = T)

  knitr::knit_hooks$set(Dot_title = function(before, options){
    if(before){
      if(options$Dot_open){
      if(is.null(options$Dot_color)){
      dot_col <- ifelse(options$engine %in% default_engines, options$engine, "others")
      } else {
      dot_col <- ifelse(options$Dot_color %in% default_engines, options$Dot_color, "others")
      }
      paste(
        '<li class="nav-item dot-li">',
        glue::glue('<a class="dot-li nav-link {ifelse(options$Dot_active, "active", "")} {paste0("dot-li-",{dot_col})} dm-dot-title"> {options$Dot_title} </a>'),
        glue::glue('<div class="dm-dot-content {ifelse(options$Dot_active, "active", "")}">'),
        sep = "\n"
      ) }
    } else {
      if(options$Dot_close){
      paste(
        '</div>',
        '</li>',
        sep = "\n"
      )}
    }
  })

  knitr::asis_output(Dotto_banner(metadata))
  #return(knitr::asis_output(Dotto_banner(metadata)))
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
<span class="likebtn-wrapper" data-theme="nero" data-i18n_like="Like Dotto" data-white_label="true" data-identifier="%s" data-show_like_label="false" data-dislike_enabled="false" data-counter_frmt="comma" data-popup_html="I like the Dotto!" data-share_size="large" data-site_id="604e13966fd08bbf03672c5b" data-i18n_like_tooltip="Like Dotto"></span>
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

