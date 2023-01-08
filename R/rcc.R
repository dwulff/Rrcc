#' Robust continuous clustering
#'
#' \code{rcc} runs the robust continuous clustering algorithm by Shah and Koltun (2017) to group objects into an appropriate number of clusters.
#'
#' \code{rcc} is a wrapper around the Python \code{pyrcc} implementation by Yann Henon (\href{https://github.com/yhenon/pyrcc}{github.com/yhenon/pyrcc}).
#'
#' @param data \code{data.frame} or \code{numeric} \code{matrix} containing the to-be-clustered objects. Columns must repreent the features, rows the objects. When a \code{data.frame} is provided all columns must be of type \code{numeric}.
#' @param k number of nearest neighbors of each object used in constructing the knn-graph.
#' @param measure distance metric. Can be \code{"euclidean"} or \code{"cosine"} to assess distance based on Euclidean distance of cosine similarity.
#' @param clustering_threshold controls how agressively to assign points to clusters. Higher numbers result in fewer larger clusters.
#' @param eps numerical epsilon used for computation. Defaults to \code{1e-05}.
#' @param verbose logical controlling the presentation of optimization statistics.
#'
#' @return \code{rcc} returns an integer vector of length \code{nrow(data)} containing the cluster assignments.
#'
#' @references Shah, S. A., & Koltun, V. (2017). Robust continuous clustering. Proceedings of the National Academy of Sciences, 114(37), 9814-9819.#' @examples
#'
#' @examples
#' \dontrun{
#' # setup -----
#'
#' # create and set environment
#' reticulate::conda_create("r-reticulate")
#' reticulate::use_condaenv("r-reticulate")
#'
#' # install rcc dependencies
#' install_rcc_dependencies()
#'
#' # run rcc -----
#'
#' # numeric variables in iris
#' iris_numerics = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
#'
#' # run rcc
#' clusters <- rcc(iris[,iris_numerics])
#'}
#'
#' @export
rcc = function(data,
               k = 10,
               measure = c('euclidean', 'cosine'),
               clustering_threshold = 1.1,
               eps = 1e-05,
               verbose = FALSE){

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

  # change to matrix
  data = as.matrix(data)

  # set up clusterer
  clusterer = pyrcc$RccCluster(as.integer(k),
                               measure[1],
                               clustering_threshold,
                               eps,
                               verbose)

  # run clusterer
  clusters = clusterer$fit(data)

  # return clusters
  clusters
  }
