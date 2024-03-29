#' A data frame with HLA haplotypes from MNDP
#'
#' @description Returns a data frame with HLA-A, -B and -DRB1 haplotypes from MNDP by race and sampled by their frequencies
#' @param n An integer to define the number of rows
#' @param replace A logical value for sampling with replacement
#' @param origin A character value from options: API', 'AFA', 'CAU' and 'HIS'
#' @return A data frame
#' @noRd
hla_sample_mndp <- function(n, replace, origin){

  if(!origin %in% c('API','AFA','CAU','HIS')){stop("Origin is not valid! Valid options: 'PT','API','AFA','CAU','HIS'")}

  if(origin == 'CAU') {
    df <- MNDPhaps[MNDPhaps$cau > 0, ]
    df <- df[sample(seq_len(nrow(df)), size = n, replace = replace, prob = df$cau),]
  }
  if(origin == 'API') {
    df <- MNDPhaps[MNDPhaps$api > 0, ]
    df <- df[sample(seq_len(nrow(df)), size = n, replace = replace, prob = df$api),]
  }
  if(origin == 'AFA') {
    df <- MNDPhaps[MNDPhaps$afa > 0, ]
    df <- df[sample(seq_len(nrow(df)), size = n, replace = replace, prob = df$afa),]
  }
  if(origin == 'HIS') {
    df <- MNDPhaps[MNDPhaps$his > 0, ]
    df <- df[sample(seq_len(nrow(df)), size = n, replace = replace, prob = df$his),]
  }

  return(df)
}

#' A data frame with HLA typing
#'
#' @description Returns a data frame with HLA-A, -B and -DRB1 typing
#' @param n A positive integer to define the number of rows
#' @param replace A logical value for sampling with replacement
#' @param origin A character value from options: 'PT', 'API', 'AFA', 'CAU' and 'HIS'
#' @return A data frame
#' @examples
#' hla_sample(n = 1000, replace = TRUE, origin = 'PT')
#' @export
#' @concept clinical_parameters
hla_sample <- function(n, replace, origin){

  #require("magrittr", quietly = TRUE)

  if(!origin %in% c('PT','API','AFA','CAU','HIS')){stop("Origin is not valid! Valid options: 'PT','API','AFA','CAU','HIS'")}

  if(!is.numeric(n) | n < 1){stop("`n` must be a single number!")}
  if(!is.logical(replace)){stop("`replace` must be logical (TRUE or FALSE)")}
  #if(!origin %in% c('PT', 'API', 'AFA', 'CAU', 'HIS')){stop("`origin` is no valid!")}

  if(origin == 'PT') {
    df <- dplyr::slice_sample(hla, n = n, replace = replace) |>
      dplyr::mutate_all(as.character)
    df <- df |>
      dplyr::rename(DR1 = DRB11, DR2 = DRB12) |>
      dplyr::select(A1, A2, B1, B2, DR1, DR2)
  }
  if(origin != 'PT') {
    df <- hla_sample_mndp(n = 2*n, replace = replace, origin = origin)
    df1 <- df |>
      dplyr::slice(1:n) |>
      dplyr::rename(A1 = A, B1 = B, DR1 = DR)
    df2 <- df |>
      dplyr::slice((n+1):(2*n)) |>
      dplyr::rename(A2 = A, B2 = B, DR2 = DR)
    df <- dplyr::bind_cols(df1, df2) |>
      dplyr::select(A1, A2, B1, B2, DR1, DR2) |>
      dplyr::mutate_all(as.character)
    }

  return(df)
}

#' Builds a vector with ABO blood group
#'
#' @description Returns a vector with ABO blood groups according to user defined
#' frequencies
#' @param n An integer to define the length of the returned vector
#' @param probs A vector with the probabilities for blood group A, AB, B and O (in this order). The sum of the probabilities must be equal to one.
#' @param seed.number Seed for pseudo random number generator.
#' @return A vector length `n` with ABO blood groups
#' @examples
#' abo(n = 100, probs = c(0.4658, 0.0343, 0.077, 0.4229), seed.number = 123)
#' @export
#' @concept clinical_parameters
abo <- function(n = 100, probs = c(0.4658, 0.0343, 0.077, 0.4229), seed.number = 123){

  if(!is.numeric(n) | n < 1){stop("`n` must be a positive number!")}
  if(round(sum(probs)) != 1){stop("`probs` do not sum 1!")}
  if(!is.numeric(seed.number) | seed.number < 1){stop("`seed.number` must be a positive number!")}

  abo <- c('A','AB','B','O')

  set.seed(seed.number)

  sample(x=abo, size = n, replace = TRUE, prob = probs)

}

#' Gives a eGFR by age
#'
#' @description Returns a value for the Estimated Glomerular Filtration Rate
#' (eGFR) by age as described by https://www.kidney.org/atoz/content/gfr.
#' @param age An integer for age (values between 1 and 99).
#' @param seed.number Seed for pseudo random number generator.
#' @return A value from a normal distribution.
#' @examples
#' aGFR(age = 43, seed.number = NA)
#' @export
#' @concept clinical_parameters
aGFR <- function(age = 43, seed.number = NA){

  if(!is.numeric(age) | age < 1 | age > 99){stop("`age` must be between 1 and 99!")}

  if(is.na(seed.number)){
    res1 <- truncnorm::rtruncnorm(n = 1, a=106, b=122, mean = 116, sd = 10)
    res2 <- truncnorm::rtruncnorm(n = 1, a=97, b=117, mean = 107, sd = 10)
    res3 <- truncnorm::rtruncnorm(n = 1, a=89, b=109, mean = 99, sd = 10)
    res4 <- truncnorm::rtruncnorm(n = 1, a=83, b=103, mean = 93, sd = 10)
    res5 <- truncnorm::rtruncnorm(n = 1, a=75, b=95, mean = 85, sd = 10)
    res6 <- truncnorm::rtruncnorm(n = 1, a=65, b=85, mean = 75, sd = 10)
  } else {
    set.seed(seed.number)
    res1 <- truncnorm::rtruncnorm(n = 1, a=106, b=122, mean = 116, sd = 10)
    res2 <- truncnorm::rtruncnorm(n = 1, a=97, b=117, mean = 107, sd = 10)
    res3 <- truncnorm::rtruncnorm(n = 1, a=89, b=109, mean = 99, sd = 10)
    res4 <- truncnorm::rtruncnorm(n = 1, a=83, b=103, mean = 93, sd = 10)
    res5 <- truncnorm::rtruncnorm(n = 1, a=75, b=95, mean = 85, sd = 10)
    res6 <- truncnorm::rtruncnorm(n = 1, a=65, b=85, mean = 75, sd = 10)
  }

  res <- ifelse(age < 30, res1,
                ifelse(age < 40, res2,
                       ifelse(age < 50, res3,
                              ifelse(age < 60, res4,
                                     ifelse(age < 70, res5,
                                            res6)))))

  return(res)

}

#' Builds a vector with cPRA (percentage)
#'
#' @description Returns a vector with cPRA percentages according to user
#' defined frequencies
#' @param n An integer to define the length of the returned vector
#' @param probs A vector with the probabilities for cPRA groups 0%, 1%-50%, 51%-84%, 85%-100% (in this order). The sum of the probabilities must be equal to one.
#' @param seed.number Seed for pseudo random number generator.
#' @return A vector length `n` with cPRA percentages
#' @examples
#' cpra(n = 100, probs = c(0.7, 0.1, 0.1, 0.1), seed.number = 123)
#' @export
#' @concept clinical_parameters
cpra <- function(n = 100, probs = c(0.7, 0.1, 0.1, 0.1), seed.number = 123){

  if(!is.numeric(n) | n < 1){stop("`n` must be a single number!")}
  if(round(sum(probs)) != 1){stop("`probs` do not sum 1!")}
  if(length(probs) != 4){stop("`probs` must be a vector with length 4!")}

  set.seed(seed.number)

  n4 <- round(n*probs[4])
  n3 <- round(n*probs[3])
  n2 <- round(n*probs[2])
  n1 <- n - (n2+n3+n4)

  v1 <- rep(0,n1)
  v2 <- extraDistr::rtpois(n = n2, lambda = 30, a = 1, b = 50)
  v3 <- extraDistr::rtpois(n = n3, lambda = 70, a = 51, b = 85)
  v4 <- extraDistr::rtpois(n = n4, lambda = 90, a = 86, b = 100)

  v <- c(v1,v2,v3,v4)

  return(sample(v))
}

#' Gives time on dialysis in months
#'
#' @description Returns a value for time on dialysis in months by blood group and cPRA.
#' @param hiper A logical value for hipersensitized patients (cPRA > 85%).
#' @param bg A character value for blood group.
#' @param mean.dial1 time on dialysis mean value for patients that are neither Hipersensitized nor blood group O, used on Normal distribution for value generation.
#' @param mean.dial2 time on dialysis mean value for patients that are Hipersensitized or blood group O, used on Normal distribution for value generation.
#' @param mean.dial3 time on dialysis mean value for patients that are Hipersensitized and blood group O, used on Normal distribution for value generation.
#' @param sd.dial time on dialysis standard deviation, used on Normal distribution for value generation.
#' @param seed.number Seed for pseudo random number generator. When `NA` no seed is applicable.
#' @return A value from a normal distribution.
#' @examples
#' dial(hiper = TRUE, bg = 'O',
#' mean.dial1 = 35, mean.dial2 = 70, mean.dial3 = 85,
#' seed.number = NA)
#' @export
#' @concept clinical_parameters
dial <- function(hiper = TRUE, bg = 'O',
                 mean.dial1 = 35,
                 mean.dial2 = 70,
                 mean.dial3 = 85,
                 sd.dial = 20,
                 seed.number = NA){

  if(!bg %in% c('A','AB','B','O')){stop("`bg` is not valid! valid blood group: 'A','AB','B','O'")}
  if(!is.logical(hiper)){stop("`hiper` must be a logical value!")}

  if(is.na(seed.number)){
    dial1 <- round(rnorm(1, mean.dial1, sd.dial))
    dial1 <- ifelse(dial1 < 0, 0, dial1)
    dial2 <- round(rnorm(1, mean.dial2, sd.dial))
    dial2 <- ifelse(dial2 < 0, 0, dial2)
    dial3 <- round(rnorm(1, mean.dial3, sd.dial))
    dial3 <- ifelse(dial3 < 0, 0, dial3)

  } else {
    set.seed(seed.number)
    dial1 <- round(rnorm(1, mean.dial1, sd.dial))
    dial1 <- ifelse(dial1 < 0, 0, dial1)
    dial2 <- round(rnorm(1, mean.dial2, sd.dial))
    dial2 <- ifelse(dial2 < 0, 0, dial2)
    dial3 <- round(rnorm(1, mean.dial3, sd.dial))
    dial3 <- ifelse(dial3 < 0, 0, dial3)
  }

  res <- ifelse(hiper == TRUE & bg == 'O', dial3,
                ifelse(hiper == TRUE | bg == 'O', dial2,
                       ifelse(dial1 < 0, 0, dial1)
                       ))

  return(res)

}



