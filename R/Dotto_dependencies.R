# popper: https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js
Dotto_dependency_popper <- function(){
  htmltools::htmlDependency(name = "popper",
                            version = "1.14.7",
                            src = system.file("templates/popper-1.14.7", package = "DataMotto"),
                            script = "popper.min.js")
}


# jquery: https://code.jquery.com/jquery-3.5.1.min.js
Dotto_dependency_jquery <- function(){
  htmltools::htmlDependency(name = "jquery",
                            version = "3.5.1",
                            src = system.file("templates/jquery-3.5.1", package = "DataMotto"),
                            script = "jquery-3.5.1.min.js")
}


# font-awesome: https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css
Dotto_dependency_font_awesome <- function(){
  htmltools::htmlDependency(name = "font-awesome",
                            version = "5.15.2",
                            src = system.file("templates/font-awesome-5.15.2", package = "DataMotto"),
                            stylesheet = c("css/all.css", "v4-shims.css"))
}

# bootstrap: https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css
Dotto_dependency_bootstrap <- function() {
  htmltools::htmlDependency(name = "bootstrap",
                            version = "4.5.3",
                            src = system.file("templates/bootstrap-4.5.3", package = "DataMotto"),
                            meta = list(viewport = "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"),
                            script = c(
                              "js/bootstrap.min.js"
                              # These shims are necessary for IE 8 compatibility
                              #"shim/html5shiv.min.js",
                              #"shim/respond.min.js"
                            ),
                            stylesheet = "css/bootstrap.min.css"
                            )
}
