#' Robust continuous clustering
#'
#' \code{rcc} runs the robust continuous clustering algorithm by Shah and Koltun (2017) to group objects into an appropriate number of clusters.
#'
#' \code{rcc} is a wrapper around the Python \code{pyrcc} implementation by Yann Henon (\href{https://github.com/yhenon/pyrcc}{github.com/yhenon/pyrcc}).
#'
#' \code{rcc} depends on the python libraries, numpy and scipy. To run the \code{rcc} function, the dependencies must be made available within a conda environment. If a conda environment is active, it wil be used. Alternatively, a conda environment name can be supplied via the \code{conda} argument or a new environment can be created and activated by the function.
#'
#' @param data \code{data.frame} or \code{numeric} \code{matrix} containing the to-be-clustered objects. Columns must repreent the features, rows the objects. When a \code{data.frame} is provided all columns must be of type \code{numeric}.
#' @param k number of nearest neighbors of each object used in constructing the knn-graph.
#' @param measure distance metric. Can be \code{"euclidean"} or \code{"cosine"} to assess distance based on Euclidean distance of cosine similarity.
#' @param clustering_threshold controls how agressively to assign points to clusters. Higher numbers result in fewer larger clusters.
#' @param eps numerical epsilon used for computation. Defaults to \code{1e-05}.
#' @param verbose logical controlling the presentation of optimization statistics.
#' @param conda name of an existing conda environment. If \code{NULL} (the default) the function will either use the currently active environment or create and activate a new one.
#'
#' @return \code{rcc} returns an integer vector of length \code{nrow(data)} containing the cluster assignments.
#'
#' @references Shah, S. A., & Koltun, V. (2017). Robust continuous clustering. Proceedings of the National Academy of Sciences, 114(37), 9814-9819.#' @examples
#'
#' @examples
#' # numeric variables in iris
#' iris_numerics = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
#'
#' # run rcc
#' clusters <- rcc(iris[,iris_numerics])
#'
#' @export
rcc = function(data,
               k = 10,
               measure = c('euclidean', 'cosine'),
               clustering_threshold = 1.1,
               eps = 1e-05,
               verbose = FALSE,
               conda = NULL){

  if(all(!c("data.frame", "matrix") %in% class(data))){
    stop("Argument data must be either data.frame or matrix.")
  }

  if("data.fame" %in% class(data)){
    if(any(!sapply(data, is.numeric))){
      stop("All columns in data must be of type numeric.")
    }
  }

  if(!measure[1] %in% c('euclidean', 'cosine')){
    stop("Argument measure must be either \"euclidean\" or \"cosine\".")
  }

  if(is.null(conda)){
    if(is.null(reticulate:::.globals$required_python_version)){
      message("No environment activated.")
      switch(menu(c("Yes", "No"), title="Create and activate conda environment? (Requires miniconda. May require a R restart.)"),
             setup_rcc_environment(),
             message("You can activate your own environment or create and activate one by running setup_rcc_environment()."))
      }
    } else {
    reticulate::use_condaenv(condaenv = conda)
    }

  # check for python libraries
  packages_available = c(reticulate::py_module_available("numpy"),
                         reticulate::py_module_available("scipy"))
  if(any(!packages_available)){
    message("Python libraries missing.")
    switch(menu(c("Yes", "No"), title="Install missing dependencies?"),
           install_rcc_dependencies(),
           message("You can install the dependencies using install_rcc_dependencies()"))
    }


  # load python
  package_path = fs::path_package("Rrcc")
  reticulate::source_python(paste0(package_path, "/pyrcc/rcc.py"))

  # change to matrix
  data = as.matrix(data)

  # set up clusterer
  clusterer = RccCluster(as.integer(k),
                         measure[1],
                         clustering_threshold,
                         eps,
                         verbose)

  # run clusterer
  clusters = clusterer$fit(data)

  # return clusters
  clusters
  }
