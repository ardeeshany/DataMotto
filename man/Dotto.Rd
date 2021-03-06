% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/01_Dotto.R
\name{Dotto}
\alias{Dotto}
\title{Create the \code{Dotto} page of DataMotto.com}
\usage{
Dotto(
  fig_width = 6,
  fig_height = 6,
  fig_caption = TRUE,
  highlight = "kate",
  lightbox = TRUE,
  thumbnails = TRUE,
  pandoc_args = NULL,
  md_extensions = "-autolink_bare_uris",
  self_contained = FALSE,
  mathjax = TRUE,
  in_header = c(social_card_protocol_dotto()$open_graph,
    social_card_protocol_dotto()$twitter),
  before_body = c(Dotto_top_header(), Dotto_sub_header()),
  after_body = Dotto_footer(),
  ...
)
}
\arguments{
\item{fig_width}{Default width (in inches) for figures}

\item{fig_height}{Default width (in inches) for figures}

\item{fig_caption}{\code{TRUE} to render figures with captions}

\item{highlight}{Syntax highlighting style. Supported styles include
"default", "tango", "pygments", "kate", "monochrome", "espresso",
"zenburn", "haddock", and "textmate". Pass \code{NULL} to prevent syntax
highlighting.}

\item{lightbox}{if TRUE, add lightbox effect to content images}

\item{thumbnails}{if TRUE display content images as thumbnails}

\item{pandoc_args}{arguments passed to the pandoc_args argument of rmarkdown \code{\link[rmarkdown]{html_document}}}

\item{md_extensions}{arguments passed to the md_extensions argument of rmarkdown \code{\link[rmarkdown]{html_document}}}

\item{...}{Additional function arguments passed to R Markdown \code{\link[rmarkdown]{html_document}}}
}
\value{
R Markdown output format to pass to \code{\link[rmarkdown]{render}}
}
\description{
Format for converting from R Markdown to a \code{Dotto} document.
}
