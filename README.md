[![cran version](http://www.r-pkg.org/badges/version/Rrcc)](https://CRAN.R-project.org/package=Rrcc)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5553980.svg)](https://doi.org/10.5281/zenodo.5553980)
[![downloads](https://cranlogs.r-pkg.org/badges/grand-total/Rrcc?color=yellow)](https://CRAN.R-project.org/package=Rrcc)

An R implementation of Robust Continuous Clustering

R wrapper for a Python implementation of robust continuous clustering (RCC) created by Yann Henon yhenon/pyrcc](https://github.com/yhenon/pyrcc). RCC is a powerful clustering algorithm that achieves high accuracy across domains, can handle high data dimensionality, and scales well to large datasets. For details see the original publication by Shah and Koltun ([2017](https://www.pnas.org/doi/10.1073/pnas.1700770114))   

## General Information

The `Rrcc` package was created and is maintained by [Dirk U. Wulff](https://github.com/dwulff).

# Installation

The current stable version is available on CRAN and can be installed via `install.packages("Rrcc")`.

The latest development version on GitHub can be installed via `devtools::install_github("dwulff/Rrcc")`. 

# Usage

Rrcc works best within a miniconda environment. The code below firses uses `reticulate` functions to install `miniconda`, creates a conda environment named `"r-reticulate"`, and activates it. The `Rrcc` function `install_rcc_dependencies()` is then used to install python dependencies, namely `scipy` and `numpy>= 1.6`. 

```R
# install miniconda
reticulate::install_miniconda()

# create and set environment
reticulate::conda_create("r-reticulate")
reticulate::use_condaenv("r-reticulate")

# install rcc dependencies
install_rcc_dependencies()
```

The code below runs robust continuous clustering using the packages `rcc()` function for the four numerical variables in the iris dataset. The `rcc()` function has several arguments to control the behavior of the clustering algrithm. 

```R
# numeric variables in iris
iris_numerics = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")

# run rcc
clusters <- rcc(iris[,iris_numerics])
```

## Citation

To cite this specific implementation, please use:

Wulff, Dirk U. (2023). R implementation of robust continuous clustering (0.1.0). Zenodo.

To cite the original method, please use:

Shah, S. A., & Koltun, V. (2017). Robust continuous clustering. Proceedings of the National Academy of Sciences, 114(37), 9814-9819.
