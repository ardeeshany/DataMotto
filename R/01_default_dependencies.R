# popper: https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js
Dotto_dependency_popper <- function(){
  htmltools::htmlDependency(name = "popper",
                            version = "1.14.7",
                            src = system.file("templates/popper-1.14.7", package = "DataMotto"),
                            script = "popper.min.js",
                            all_files = F)
}


# jquery: https://code.jquery.com/jquery-3.5.1.min.js
Dotto_dependency_jquery <- function(){
  htmltools::htmlDependency(name = "jquery",
                            version = "3.5.1",
                            src = system.file("templates/jquery-3.5.1", package = "DataMotto"),
                            script = "jquery-3.5.1.min.js",
                            all_files = F)
}

# jquery: https://code.jquery.com/jquery-3.5.1.min.js
Dotto_dependency_jquery_slim <- function(){
  htmltools::htmlDependency(name = "jquery_slim",
                            version = "3.3.1",
                            src = system.file("templates/jquery-3.3.1", package = "DataMotto"),
                            script = "jquery-3.3.1.slim.min.js",
                            all_files = F)
}

# font-awesome: https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css
Dotto_dependency_font_awesome <- function(){
  htmltools::htmlDependency(name = "font-awesome",
                            version = "5.15.2",
                            src = system.file("templates/font-awesome-5.15.2", package = "DataMotto"),
                            stylesheet = c("css/all.css", "css/v4-shims.css"),
                            all_files = T)
}

# bootstrap: https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css
Dotto_dependency_bootstrap <- function() {
  htmltools::htmlDependency(name = "bootstrap",
                            version = "4.5.3",
                            src = system.file("templates/bootstrap-4.5.3/css", package = "DataMotto"),
                            meta = list(viewport = "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"),
                            # script = c(
                            #   "js/bootstrap.min.js"
                            #   # These shims are necessary for IE 8 compatibility
                            #   #"shim/html5shiv.min.js",
                            #   #"shim/respond.min.js"
                            # ),
                            stylesheet = "bootstrap.min.css",
                            all_files = F)
}



# https://github.com/twbs/bootstrap/releases/download/v4.3.1/bootstrap-4.3.1-dist.zip
Dotto_dependency_bootstrap_js <- function() {
  htmltools::htmlDependency(name = "bootstrap_js",
                            version = "4.3.1",
                            src = system.file("templates/bootstrap-4.3.1", package = "DataMotto"),
                            script = "bootstrap.min.js",
                            all_files = F)
}

# https://highlightjs.org/
Dotto_dependency_PrismJS <- function() {
  htmltools::htmlDependency(name = "highlightjs",
                            version = "10.6.0",
                            src = system.file("templates/highlightjs-10.6.0", package = "DataMotto"),
                            head = list('<script>hljs.initHighlightingOnLoad();</script>'),
                            script = "highlight.pack.js",
                            stylesheet = "xcode.css",
                            all_files = F)
}



# icomoon: Add font-awesome-style icons for julia, sql, etc
Dotto_dependency_icons <- function() {
  htmltools::htmlDependency(name = "icons",
                            version = "0.1.0",
                            src = system.file("templates/icons", package = "DataMotto"),
                            stylesheet = "style.css",
                            all_files = T)
}









