
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simK <img src="man/figures/logo.png" height="150" align="right"/>

<!-- badges: start -->

[![](https://img.shields.io/badge/devel%20version-0.1.2-blue.svg)](https://github.com/txopen/simK)
[![R-CMD-check](https://github.com/txopen/simK/workflows/R-CMD-check/badge.svg)](https://github.com/txopen/simK/actions)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![License:
CC-BY4](https://img.shields.io/badge/license-CC--BY4-blue.svg)](https://creativecommons.org/licenses/by/4.0/)
<!-- badges: end -->

**License**: Creative Commons Attribution
[CC-BY](https://creativecommons.org/licenses/by/2.0/). Feel free to
share and adapt, but don’t forget to credit the author. :sunglasses:

:dart: Functions to procedurally generate synthetic data in R for kidney
transplant simulations. You can see `simK` in action,
[here](https://simk.netlify.app/).

`simK` allows to generate data with clinical and demographic information
for a pool of simulated cadaveric donors and simulated wait listed
candidates for kidney transplantation.

Data generated with `simK` are particularly useful on
[KARS](https://balima.shinyapps.io/kars/).

> :warning: This package is not a medical device and <ins>should not be
> used for making clinical decisions</ins>.

## Instalation

### Development version

The development version can be installed from GitHub, if you want all
the latest features, together with all the latest bugs and errors. You
have been warned :exclamation:

    # install from GitHub
    devtools::install_github("txopen/simK")

## Main functions

This package has 3 main functions, with them we can generate simulated
data for a pool of donors, a set of kidney transplant candidates and the
respective HLA-antibodies for those patients HLA sensitized.

A detailed description of these functions usage, is available from
[here](https://txopen.github.io/simK/articles/simk.html).

:warning: For PT origin, all these functions rely on HLA typing at
intermediate resolution as described at [Lima *et al*,
2013](https://12f11c1f-960a-f627-594d-b8ce276384f7.filesusr.com/ugd/3e838e_dc548dede99a4db5869c3d2c20c2d16f.pdf?index=true).

:warning: For NMDP populations, HLA typing were described by [Gragert
*et al*,
2013](https://reader.elsevier.com/reader/sd/pii/S0198885913001821?token=885F05F0FAD857548C932A5CC40B6962CD7A9FC589A73FC6DECE56D6E4E247587E06D755C16D9F2EA425111289B5DC2F&originRegion=eu-west-1&originCreation=20220222173605)
