# scipy <- NULL
# numpy <- NULL
# pyrcc <- NULL

.onAttach <- function(libname, pkgname){

  # ask for miniconda install
  packageStartupMessage("Rrcc Version 0.1.0\n\nRrcc depends on miniconda. You can install miniconda using reticulate::install_miniconda().")

}

# .onLoad <- function(libname, pkgname) {
#
#   # use superassignment to update global reference to scipy
#   scipy <<- reticulate::import("scipy", delay_load = TRUE)
#   numpy <<- reticulate::import("numpy", delay_load = TRUE)
#   #pyrcc <<- reticulate::import("pyrcc", delay_load = TRUE)
#   }
