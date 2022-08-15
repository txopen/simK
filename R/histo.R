#' number of HLA mismatchs
#'
#' @description Computes the number of HLA mismatchs between one donor and one candidate
#' @param dA donor's HLA-A typing
#' @param dB donor's HLA-B typing
#' @param dDR donor's HLA-DR typing
#' @param cA candidate's HLA-A typing
#' @param cB candidate's HLA-B typing
#' @param cDR candidate's HLA-DR typing
#' @return mmA number of HLA-A mismatchs between \code{dA} and \code{cA};
#' mmB number of HLA-B mismatchs between \code{dB} and \code{cB};
#' mmDR number of HLA-DR mismatchs between \code{dDR} and \code{cDR};
#' and mmHLA as the sum of mmA + mmB + mmDR
#' @examples
#' mmHLA(dA = c('1','2'), dB = c('5','7'), dDR = c('1','4'),
#' cA = c('1','2'), cB = c('03','15'), cDR = c('04','07'))
#' @export
#' @concept histocompatibility
mmHLA <- function(dA = c('1','2'), dB = c('5','7'), dDR = c('1','4'),
                  cA = c('1','2'), cB = c('3','15'), cDR = c('4','7')){

    if(!is.character(dA)){stop("donor's HLA-A typing is not valid!\n")}
    if(!is.character(dB)){stop("donor's HLA-B typing is not valid!\n")}
    if(!is.character(dDR)){stop("donor's HLA-DR typing is not valid!\n")}
    if(!is.character(cA)){stop("candidate's HLA-A typing is not valid!\n")}
    if(!is.character(cB)){stop("candidate's HLA-B typing is not valid!\n")}
    if(!is.character(cDR)){stop("candidate's HLA-DR typing is not valid!\n")}

    mmA <- NULL
    mmB <- NULL
    mmDR <- NULL

    # compute missmatches
    mmA <- dplyr::if_else((dA[1] %in% cA & dA[2] %in% cA) | (dA[1] %in% cA & (is.na(dA[2]) | dA[2] == "")), 0,
                          dplyr::if_else(dA[1] %in% cA | dA[2] %in% cA, 1,
                                         dplyr::if_else(!dA[1] %in% cA & (is.na(dA[2]) | dA[2] == ""), 1,
                                                        dplyr::if_else(dA[1] == dA[2], 1,2))))

    mmB <- dplyr::if_else((dB[1] %in% cB & dB[2] %in% cB) | (dB[1] %in% cB & (is.na(dB[2]) | dB[2] == "")), 0,
                          dplyr::if_else(dB[1] %in% cB | dB[2] %in% cB, 1,
                                         dplyr::if_else(!dB[1] %in% cB & (is.na(dB[2]) | dB[2] == ""), 1,
                                                        dplyr::if_else(dB[1] == dB[2], 1,2))))

    mmDR <- dplyr::if_else((dDR[1] %in% cDR & dDR[2] %in% cDR) | (dDR[1] %in% cDR & (is.na(dDR[2]) | dDR[2] == "")), 0,
                           dplyr::if_else(dDR[1] %in% cDR | dDR[2] %in% cDR, 1,
                                          dplyr::if_else(!dDR[1] %in% cDR & (is.na(dDR[2]) | dDR[2] == ""), 1,
                                                         dplyr::if_else(dDR[1] == dDR[2],1,2))))

    mmHLA <- mmA + mmB + mmDR
    mm <- c(mmA,mmB,mmDR,mmHLA)
    names(mm) <- c("mmA","mmB","mmDR","mmHLA")

    return(mm)


  # # compute missmatches with base ifelse
  # mmA<-ifelse((dA[1] %in% cA & dA[2] %in% cA) | (dA[1] %in% cA & (is.na(dA[2]) | dA[2] == "")), 0,
  #             ifelse(dA[1] %in% cA | dA[2] %in% cA, 1,
  #                    ifelse(!dA[1] %in% cA & (is.na(dA[2]) | dA[2] == ""), 1,
  #                           ifelse(dA[1] == dA[2], 1,2))))
  #
  # mmB<-ifelse((dB[1] %in% cB & dB[2] %in% cB) | (dB[1] %in% cB & (is.na(dB[2]) | dB[2] == "")), 0,
  #             ifelse(dB[1] %in% cB | dB[2] %in% cB, 1,
  #                    ifelse(!dB[1] %in% cB & (is.na(dB[2]) | dB[2] == ""), 1,
  #                           ifelse(dB[1] == dB[2], 1,2))))
  #
  # mmDR<-ifelse((dDR[1] %in% cDR & dDR[2] %in% cDR) | (dDR[1] %in% cDR & (is.na(dDR[2]) | dDR[2] == "")), 0,
  #              ifelse(dDR[1] %in% cDR | dDR[2] %in% cDR, 1,
  #                     ifelse(!dDR[1] %in% cDR & (is.na(dDR[2]) | dDR[2] == ""), 1,
  #                            ifelse(dDR[1] == dDR[2],1,2))))

}

#' Matchability from D10K
#'
#' @description Computes the number donors on dataset D10K that are a match to
#' a given transplant candidate. A sample of D10K is selected according to
#' cPRA value, afterwards donors ABO identical and HLA mismatch level 1 or 2
#' (0 DR or (1 DR and 0 B)) are filtered.
#' @param cABO A character from 'A', 'B', 'AB', 'O'
#' @param cPRA candidate's cPRA value
#' @param cA candidate's HLA-A typing
#' @param cB candidate's HLA-B typing
#' @param cDR candidate's HLA-DR typing
#' @param seed.number a numeric seed that will be used for random number generation.
#' @return Match Score measure of how difficult it is to match a patient with a organ donor. A score from 1 (easy to match) to 10 (difficult to match).
#' @examples
#' matchability(cABO = 'A', cPRA = 85,
#' cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
#' seed.number = 3)
#' @export
#' @concept histocompatibility
matchability <- function(cABO = 'A', cPRA = 85,
                         cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
                         seed.number = 3){
  if(!cABO %in% c('A','AB','B','O')){stop("Blood group is not valid! Valid options: 'A','AB','B','O'")}

  #require('magrittr', quietly = TRUE)

  set.seed(seed.number)

  n1 <- (100-cPRA)*100

  n.donors <- dplyr::sample_n(D10K, size = n1) |>
    dplyr::filter(bg == cABO) |>
    dplyr::mutate_if(is.numeric, as.character) |>
    dplyr::rowwise() |>
    dplyr::mutate(mmB = mmHLA(dA = c(A1,A2), dB = c(B1,B2), dDR = c(DR1,DR2),
                              cA = cA, cB = cB, cDR = cDR)['mmB'],
                  mmDR = mmHLA(dA = c(A1,A2), dB = c(B1,B2), dDR = c(DR1,DR2),
                               cA = cA, cB = cB, cDR = cDR)['mmDR'],
                  level12 = mmDR == 0 | (mmB == 0 & mmDR == 1)) |>
    dplyr::ungroup() |>
    dplyr::filter(level12) |> nrow()

  return(n.donors)

}

#' virtual PRA
#'
#' @description Computes virtual PRA (vPRA) form HLA-A, -B, -DR loci.
#' @param abs A character vector with HLA antibodies.
#' @param donors A dataframe with HLA typing for a pool of donors.
#' @return a percentual value for vPRA
#' @examples
#' vpra(abs = c('A1','A2','B5','DR4'), donors = D10K)
#' @export
#' @concept histocompatibility
vpra <- function(abs = c('A1','A2','B5','DR4'), donors = D10K){

  #require("magrittr", quietly = TRUE)

  n <- nrow(donors)

  na <- donors |>
    dplyr::mutate_at(dplyr::vars(A1,A2), function(x) paste0('A',x)) |>
    dplyr::mutate_at(dplyr::vars(B1,B2), function(x) paste0('B',x)) |>
    dplyr::mutate_at(dplyr::vars(DR1,DR2), function(x) paste0('DR',x)) |>
    dplyr::filter(A1 %in% abs | A2 %in% abs |
                    B1 %in% abs | B2 %in% abs |
                    DR1 %in% abs | DR2 %in% abs) |>
    nrow()

  res <- round(na/n * 100,1)

  return(res)

}

#' samples HLA antibodies
#'
#' @description creates a sample of HLA antibodies (abs) for a given candidate
#' according with a cPRA value.
#' @param cA candidate's HLA-A typing
#' @param cB candidate's HLA-B typing
#' @param cDR candidate's HLA-DR typing
#' @param cPRA candidate's cPRA value
#' @param origin A character value from options: 'PT', 'API', 'AFA', 'CAU' and 'HIS'
#' @param seed.number a numeric seed that will be used for random number generation.
#' @return a character vector with HLA abs.
#' @examples
#' antbs(cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
#' cPRA = 85, origin = 'PT', seed.number = 3)
#' @export
#' @concept histocompatibility
antbs <- function(cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
                  cPRA = 85,
                  origin = 'PT', seed.number = 3){

  set.seed(seed.number)

  typing <- c(paste0('A',cA), paste0('B',cB), paste0('DR',cDR))

  if(!origin %in% c('PT','API','AFA','CAU','HIS')){stop("Origin is not valid! Valid options: 'PT','API','AFA','CAU','HIS'")}

  if(origin == 'PT') {
    valid.ags <- c(agA, agB, agDR)[!c(agA, agB, agDR) %in% typing]
    dd <- D10K
  } else {
    valid.ags <- c(agA_MNDP, agB_MNDP, agDR_MNDP)[!c(agA, agB, agDR) %in% typing]
    if(origin == 'API'){dd <- D10K_API}
    if(origin == 'AFA'){dd <- D10K_AFA}
    if(origin == 'CAU'){dd <- D10K_CAU}
    if(origin == 'HIS'){dd <- D10K_HIS}
    }

  # if(origin == 'PT'){
  #   vpra <- function(abs){vpra(abs, donors = D10K)}
  # }
  # if(origin == 'API') vpra <- function(abs) vpra(abs, donors = D10K_API)
  # if(origin == 'AFA') vpra <- function(abs) vpra(abs, donors = D10K_AFA)
  # if(origin == 'CAU') vpra <- function(abs) vpra(abs, donors = D10K_CAU)
  # if(origin == 'HIS') vpra <- function(abs) vpra(abs, donors = D10K_HIS)

  c = NULL
  if(cPRA > 0){
    for(i in 1:250){
      c[i] <- sample(valid.ags, 1, replace = F)

      if(vpra(c, donors = dd)>cPRA-3){ break }
    }
  }

  vpra <- vpra(c, donors = dd)

  list(cPRA = cPRA,
       vPRA = vpra,
       HLA = typing,
       Valid.Ags = valid.ags,
       Abs = c)

}
