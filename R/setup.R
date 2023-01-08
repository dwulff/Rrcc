#' Setup rcc environment
#'
#' \code{setup_rcc_environment} creates and activates Rrcc environment.
#'
#' @param verbose logical controlling verbosity of function.
#'
#' @return Nothing. Conda environment is created and activated.
#'
#' @examples
#' \dontrun{
#' setup_rcc_env()
#'}
#'
#' @export
setup_rcc_environment = function(verbose = TRUE){

  # check if miniconda exists
  path = reticulate::miniconda_path()
  check = !is.null(path) && !is.na(path) && file.exists(path)
  if(check) stop("miniconda is missing. Install using reticulate::install_miniconda().")

  # create environment
  reticulate::conda_create("Rrcc")
  cat("\nRrcc environment created.")

  # activate environment
  reticulate::use_condaenv("Rrcc")
  cat("\nRrcc environment activated.\n")

  }
