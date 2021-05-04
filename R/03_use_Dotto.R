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

  knitr::opts_chunk$set(message = FALSE,
                        warning = FALSE,
                        class.source = "dotto-dot-code",
                        fig.align = "left")

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
<div class="box overflow-auto dotto-main-intro dotto-dot-instruction">
<div class="card-header">
<h1>&nbsp;Instructions:</h1>
</div>
<br>
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
<div class="box2 dotto-main overflow-auto dotto-main-codes">
<div class="card-header">
<h1>&nbsp;Codes:</h1>
</div>
<br>
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
<div class="box2 dotto-main overflow-auto dotto-main-output">
<div class="card-header">
<h1>&nbsp;Results:</h1>
</div>
<br>
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

# Utilities -------------------------------------------

lang_icon_class <- function(lang, full_name = F) {
  if(tolower(lang) == "r"){
    icon <- "fab fa-r-project"
  } else if(tolower(lang) == "python"){
    icon <- "fab fa-python"
  } else if(tolower(lang) == "sql"){
    icon <- "icon-file-sql"
  } else {
    icon <- "fas fa-database"
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

