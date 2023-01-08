scipy <- NULL
numpy <- NULL
pyrcc <- NULL

.onAttach <- function(libname, pkgname){

  # ask for miniconda install
  packageStartupMessage("Rcc Version 0.1.0.\n\nRrcc runs best with miniconda. Install using reticulate::install_miniconda(). Downloads 50MB and takes some time.")

}


.onLoad <- function(libname, pkgname) {

  # use superassignment to update global reference to scipy
  scipy <<- reticulate::import("scipy", delay_load = TRUE)
  numpy <<- reticulate::import("numpy", delay_load = TRUE)
  pyrcc <<- reticulate::import("inst.pyrcc", delay_load = TRUE)

  }
