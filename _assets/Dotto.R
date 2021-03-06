#' Adds a `dotto` style page
#' @details It should be included in the beginning of the post page.
#' @export
use_dotto <- function() {
  #register_dotto_knitr_hooks()
  # htmltools::tagList(
  #   html_dependency_dotto()
  # )
  #htmltools::includeCSS(here::here("inst","dotto","dotto.css"))
  #htmltools::includeScript(here::here("inst","dotto","dotto.js"))
}


html_dependency_dotto <- function() {
  htmltools::htmlDependency(
    name = "dotto",
    version = utils::packageVersion("DataMotto"),
    package = "DataMotto",
    src = "dotto",
    script = "dotto.js",
    stylesheet = "dotto.css"
  )
}

dotto <- function(params) {

#### -----------------------------
nav_dotto <- htmltools::HTML("
<section id='dm-post-header'>
<div class='container'>
<header id='dm-header' class='pt-3 pb-2 clearfix'>
<div id='dm-logo' class='float-left'>
<div class='dm-logo-dot'></div>
<div class='dm-logo-dot'></div>
<div class='dm-logo-dot'></div>
<span>DATA MOTTO</span>
</div>
<nav class='float-left pl-5 pt-2' id='dm-nav'>
<ul class='row'>
<li class='d-inline-block'><a href='#'>HOME</a></li>
<li class='d-inline-block pl-4'><a href='#'>THE WHOLE GAME!</a></li>
<li class='d-inline-block pl-4'><a href='#'>BLOG</a></li>
<li class='d-inline-block pl-4'><a href='#'>ABOUT</a></li>
</ul>
<div class='dropdown' id='dm-mo-nav'>
<button type='button' class='btn gradient-button text-white rounded-pill dropdown-toggle' data-toggle='dropdown'>
<i class='fa fa-bars' aria-hidden='true'></i>
</button>
<div class='dropdown-menu' id='dm-mobile-content'>
<a class='dropdown-item' href='#'>HOME</a>
<a class='dropdown-item' href='#'>THE WHOLE GAME!</a>
<a class='dropdown-item' href='#'>BLOG</a>
<a class='dropdown-item' href='#'>ABOUT</a>
</div>
</div>
</nav>
<button class='float-right btn gradient-button text-white rounded-pill' id='get-started'>GET STARTED</button>
</header>
</div>
</section>")


#### -----------------------------
header_dotto <- htmltools::HTML("
<section id='dm-post' class='pt-4'>
<div class='container'>
<div class='row'>

<div id='dotto' class='col-md-1 pr-md-0 pl-md-0'>
<ul class='hasDotto'>
<li class='dotto-active' data-id='1'>
<div class='dm-rep'>
<div class='dm-rep-btn' data-post-id='1'><i class='fas fa-caret-up'></i></div>
<div class='dm-rep-btn-loading spin'><i class='fas fa-circle-notch'></i></div>
</div>
<div class='total-likes' data-post-id='1'>0</div>
<div class='dotto-dots click-dots' data-toggle='tooltip' data-placement='top' title='Test Title'></div>
</li>

</ul>
</div>

<div id='dotto-content' class='col-md-11 pr-md-0 pl-md-0'>
<div class='dotto-container' style='display: block;' data-id='1'>
<div id='dm-desc'>
<div class='row'>
<div class='col-md-6'>
<h2>",params$title, "</h2>
<p>", params$description, "</p>
</div>
<div class='col-md-4'>
<div id='dm-techs'>
<i class='fab fa-python'></i>
</div>
<div id='dm-tags' class='pt-2'>
<span class='badge badge-pill badge-info'>Visualization</span>
</div>

</div>
<div class='col-md-2'>
<div class='dm-posts-desc'>
<span class='pr-1'><i class='far fa-clock'></i>", params$date, "</li>
<br/>
<span><i class='far fa-user'></i>", params$author, "</li>
</div>
</div>
</div>
</div>")




# -----------------------------
main_dotto <- htmltools::HTML("
<ul class='nav nav-tabs'>

<li class='nav-item'>
<a class='nav-link active dm-dot-title'>Intro</a>
<div class='dm-dot-content active'>
Intro
</div>
</li>

<li class='nav-item'>
<a class='nav-link dm-dot-title'>Data</a>
<div class='dm-dot-content'>
Data
</div>
</li>
<li class='nav-item'>
<a class='nav-link dm-dot-title'>Cleaning</a>
<div class='dm-dot-content'>
Cleaning
</div>
</li>
<li class='nav-item'>
<a class='nav-link dm-dot-title'>Visulization</a>
<div class='dm-dot-content'>
Visulization
</div>
</li>
")

# ---------------------------------
footer_dotto <- htmltools::HTML("
<footer id='dm-footer' class='pt-3 pb-3'>
<div class='container'>
<div id='dm-social' class='text-center'>
<a href='https://twitter.com/DataMotto' class='fab fa-twitter'></a>
<a href='https://www.linkedin.com/company/datamotto' class='fab fa-linkedin'></a>
<a href='https://Datamotto.slack.com' class='fab fa-slack'></a>
</div>
<div id='dm-copy' class='text-center mt-3'>copyright <i class='fas fa-copyright'></i> 2021</div>
</div>
</footer>
")

# -------------------------
htmltools::tagList(htmltools::tags$script(src="https://www.gstatic.com/firebasejs/8.2.4/firebase.js"),
                   htmltools::tags$script(src="https://www.gstatic.com/firebasejs/8.2.4/firebase-analytics.js"),
                   htmltools::includeScript(here::here("inst","dotto","dotto.js")),
                   #nav_dotto,
                   header_dotto,
                   main_dotto,
                   #footer_dotto,
                   html_dependency_dotto())
}
