#' Dotto extensions
#'
#' Adds required extensions that are necessary for setting up
#' Rmd file gets `Dotto` style.
#'
#' @details Add the following code chunk to your Rmarkdown file with output \code{DataMotto::Dotto}.
#'   \code{```{r datamotto_dotto, echo=FALSE}
#'         DataMotto::use_dotto()
#'         ```}
#' @importFrom htmltools HTML
#' @importFrom knitr knit_hooks
#' @importFrom glue glue
#' @export
#'
#'@examples
#'\dontrun{
#' DataMotto::use_dotto()
#'}
use_dotto <- function(metadata) {
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
<div id="dm-desc">
<div class="row">
<div class="col-md-6">
<h2>%s</h2>
<p>%s</p>
</div>
', metadata$title, metadata$description)

# techs and categories -------------------------------
col_2 <- sprintf('
<div class="col-md-3">
<div class="dm-posts-techs">
<div class="row">
%s
</div>
<div class="row">
%s
</div>
</div>
</div>
',dotto_techs(metadata) ,dotto_categories(metadata))


# date and author ------------------------------------
col_3 <- sprintf('
<div class="col-md-3">
<div class="dm-posts-desc">
<div class="row">
<span class="pr-1"> <i class="far fa-clock" style="margin: 2px;"></i> %s </span>
</div>
<div class="row">
%s
</div>
</div>
</div>
', metadata$date, dotto_authors(metadata))

return(sprintf(
'
%s
%s
%s
</div>
</div>
<ul class="nav nav-tabs">
', col_1, col_2, col_3))

#glue::glue("<span><i class=\'far fa-user\'></i><a href={dotto_yml$author[[i]]$name} target=\'_blank\'> {dotto_yml$author[[i]]$url}</a></span>")
# date

# <div class="col-md-4">
#
# <div class="row">
# $for(techs)$
# <div class="dm-techs">
# $techs.icon$
# <br/>
# </div>
# $endfor$
# </div>
#
# <div id="dm-tags" class="pt-2">
# $if(categories)$
# <span class="badge badge-pill badge-info">$categories$</span>
# $endif$
# </div>
# </div>


# <div class="col-md-2">
# <div class="dm-posts-desc">
# $if(date)$
# <span class="pr-1"><i class="far fa-clock"></i> $date$</span>
# $endif$
# <br/>
# $for(author)$
# $if(author.name)$ <span><i class="far fa-user"></i><a href=$author.url$ target="_blank"> $author.name$</a></span> $endif$
# $sep$, $endfor$
# </div>
# </div>
}

#' Extract category information in HTML format
#' @noRd
dotto_authors <- function(metadata){
  vec <- rep(NA, length(metadata$author))
  for(i in 1:length(metadata$author)){
    vec[i] <- sprintf('
<span style="margin-right: .75em;"> <i class="far fa-user"></i> <a href=%s target="_blank"> %s</a></span>
', metadata$author[[i]]$url, metadata$author[[i]]$name)
  }
  return(paste0(vec, collapse = ""))
}


#' Extract categories in HTML format
#' @noRd
dotto_categories <- function(metadata){
  vec <- rep(NA, length(metadata$categories))
  for(i in 1:length(metadata$categories)){
    vec[i] <- sprintf('
<span class="badge badge-pill badge-info" style="margin-right: 2px; font-size:11px;">%s</span>
', metadata$categories[i])
  }
  return(paste0(vec, collapse = ""))
}


tech_html_icon <- function(lang) {
  if(tolower(lang) == "r"){
    icon <- '<i class="fab fa-r-project fa-lg" style="margin: 0"></i>'
  } else if(tolower(lang) == "python"){
    icon <- '<i class="fab fa-python fa-lg" style="margin: 0"></i>'
  } else {
    icon <- NULL
  }
  return(icon)
}

#' Extract tech information in HTML format
#' @noRd
dotto_techs <- function(metadata){
  vec <- rep(NA, length(metadata$techs))
  for(i in 1:length(metadata$techs)){
    vec[i] <- sprintf('
<span style="margin-right: 0.5em;">%s</span>
', tech_html_icon(metadata$techs[[i]]$lang))
  }
  return(paste0(vec, collapse = ""))
}

# cc <- rmarkdown::yaml_front_matter(paste(getwd(), "forcats.Rmd", sep = "/"))
# cc$categories
# '<i class="fab fa-r-project"></i>'
#



