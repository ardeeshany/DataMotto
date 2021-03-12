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
  return(knitr::asis_output(Dotto_banner(metadata)))
}




#' Add banner card on top of Dotto
Dotto_banner <- function(metadata){


col_1 <- sprintf('
<div id="dm-desc">
<div class="row">
<div class="col-md-6">
<h2>%s</h2>
<p>%s</p>
</div>
', metadata$title, metadata$description)

dotto_authors <- function(authors){
a <- rep(NA, length(authors))
for(i in 1:length(authors)){
a[i] <- sprintf('
<i class="far fa-user"></i> <a href=%s target="_blank"> %s</a>
', authors[[i]]$url, authors[[i]]$name)
}
  return(paste0(a, collapse = ","))
}

col_3 <- sprintf('
<div class="col-md-3">
<div class="dm-posts-desc">
<span class="pr-1"> <i class="far fa-clock"></i>%s</span>
<br/> <br/>
<span>%s</span>
</div>
</div>
', metadata$date, dotto_authors(metadata$author))


return(glue::glue('
  {col_1}
  {col_3}
  </div>
  </div>
  <ul class="nav nav-tabs">
'))

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

