#' Install rcc dependencies
#'
#' \code{install_rcc_dependencies} installs or updates numpy and scipy.
#'
#' @param method character string passed on to argument of the same name in \link[reticulate]{py_install}.
#' @param conda character string passed on to argument of the same name in \link[reticulate]{py_install}.
#'
#' @return Nothing. Libraries are installed in the current python environment.
#'
#' @examples
#' \dontrun{
#' install_rcc_dependencies()
#'}
#'
#' @export
install_rcc_dependencies = function(method = "auto", conda = "auto"){

  # install python libraries
  reticulate::py_install(packages = "scipy", method = method, conda = conda)
  reticulate::py_install(packages = "numpy>= 1.6", method = method, conda = conda)

  }
