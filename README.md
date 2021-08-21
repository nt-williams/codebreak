
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codebreak

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/nt-williams/dictionary/workflows/R-CMD-check/badge.svg)](https://github.com/nt-williams/dictionary/actions)
[![codecov](https://codecov.io/gh/nt-williams/codebook/branch/main/graph/badge.svg?token=QGGA7OE5UY)](https://codecov.io/gh/nt-williams/codebook)

<!-- badges: end -->

Quickly and easily label your data using codebooks saved as a
[YAML](https://yaml.org/) text file.

## Installation

``` r
remotes::install_github("nt-williams/codebreak")
```

or

``` r
# Install 'codebook' from 'nt-williams' universe
install.packages('codebreak', repos = 'https://nt-williams.r-universe.dev')
```

## Applying a code book

``` r
some_data <- data.frame(
     x = c(1, 2, 5, 3, 4, 1),
     y = c(0, 1, 1, 0, 1, 9), 
     z = c(5.2, 3.1, 5.6, 8.9, 9.0, 7.2), 
     w = c(1, 1, 0, 1, 1, 1)
)
```

Codebooks are created as YAML text files and are saved in the project
directory (or somewhere else) as `codebook.yml` (or as something else).

``` yaml
x:
  label: Variable X
  cb:
    1: These
    2: Are
    3: Random
    4: Character
    5: Labels

"y":
  label: Variable Y
  cb: &binary
    0: "No"
    1: "Yes"
    9: null

z:
  label: Variable Z

w:
  label: Variable W
  cb: *binary
```

Apply the codebook to the data:

``` r
codebreak::decode(some_data)
#>           x    y   z   w
#> 1     These   No 5.2 Yes
#> 2       Are  Yes 3.1 Yes
#> 3    Labels  Yes 5.6  No
#> 4    Random   No 8.9 Yes
#> 5 Character  Yes 9.0 Yes
#> 6     These <NA> 7.2 Yes
```

Rename columns based on the codebook labels:

``` r
codebreak::label(some_data)
#>   Variable X Variable Y Variable Z Variable W
#> 1          1          0        5.2          1
#> 2          2          1        3.1          1
#> 3          5          1        5.6          0
#> 4          3          0        8.9          1
#> 5          4          1        9.0          1
#> 6          1          9        7.2          1
```

Apply the codebook and rename columns:

``` r
codebreak::decode(some_data, label = TRUE)
#>   Variable X Variable Y Variable Z Variable W
#> 1      These         No        5.2        Yes
#> 2        Are        Yes        3.1        Yes
#> 3     Labels        Yes        5.6         No
#> 4     Random         No        8.9        Yes
#> 5  Character        Yes        9.0        Yes
#> 6      These       <NA>        7.2        Yes
```

## Integration with the `labelled` package

`decode()` and `label()` can return data with the codebook applied using
the [`labelled`](https://CRAN.R-project.org/package=labelled) package by
setting `as_labelled = TRUE`.

``` r
some_data <- tibble::as_tibble(some_data)

codebreak::decode(some_data, as_labelled = TRUE)
#> # A tibble: 6 × 4
#>               x         y     z         w
#>       <dbl+lbl> <dbl+lbl> <dbl> <dbl+lbl>
#> 1 1 [These]       0 [No]    5.2   1 [Yes]
#> 2 2 [Are]         1 [Yes]   3.1   1 [Yes]
#> 3 5 [Labels]      1 [Yes]   5.6   0 [No] 
#> 4 3 [Random]      0 [No]    8.9   1 [Yes]
#> 5 4 [Character]   1 [Yes]   9     1 [Yes]
#> 6 1 [These]      NA         7.2   1 [Yes]
```
