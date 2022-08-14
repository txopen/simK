#' Builds a vector with truncated ages
#'
#' @description Returns a vector with ages with a normal distribution truncated
#' by upper and upper limits.
#' @param n An integer to define the length of the returned vector.
#' @param lower An integer for ages' lower limit.
#' @param upper An integer for ages' upper limit.
#' @param mean A value for mean's distribution.
#' @param sd A value for standar deviation's distribution.
#' @param seed.number Seed for pseudo random number generator.
#' @return A vector length `n` with normal distributed truncated ages.
#' @examples
#' ages(n = 100, lower=18, upper=75, mean = 55, sd = 15, seed.number = 123)
#' @export
#' @concept demographic_parameters
ages <- function(n = 100, lower=18, upper=75, mean = 55, sd = 15, seed.number = 123){

  if(!is.numeric(n) | n < 1){stop("`n` must be a positive single number!\n")}
  if(!is.numeric(mean) | mean < 1){stop("`mean` must be a positive single number!\n")}
  if(!is.numeric(sd) | sd < 1){stop("`sd` must be a positive single number!\n")}
  if(!is.numeric(lower) | lower < 1){stop("`lower` must be a positive single number!\n")}
  if(!is.numeric(upper) | upper < 1){stop("`upper` must be a positive single number!\n")}

  set.seed(seed.number)

  round(
    truncnorm::rtruncnorm(n = n, a=lower, b=upper, mean = mean, sd = sd)
  )

}



