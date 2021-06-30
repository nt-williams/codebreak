
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dictionary

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Quickly label your data using data dictionaries saved as JSON files.

## Usage

``` r
some_data <- data.frame(
     x = c(1, 2, 5, 3, 4),
     y = c(0, 1, 1, 0, 1), 
     z = c(5.2, 3.1, 5.6, 8.9, 9.0)
)
```

Your data dictionary as a JSON file, saved in your project directory (or
somewhere else) as `dictionary.json`.

``` json
{
  "x": {
      "1": "These",
      "2": "Are",
      "3": "Random",
      "4": "Factor",
      "5": "Labels"
  },
  "y": {
    "0": "No",
    "1": "Yes"
  }
}
```

Apply the dictionary to the coded data:

``` r
dictionary(some_data)
#>        x   y   z
#> 1  These  No 5.2
#> 2    Are Yes 3.1
#> 3 Labels Yes 5.6
#> 4 Random  No 8.9
#> 5 Factor Yes 9.0
```