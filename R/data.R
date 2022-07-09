#' HLA typing.
#'
#' A dataset containing HLA typing from 37993 unrelated voluntary bone marrow donors from Nothern Portugal, recruited between 2010 and 2011.
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{C1}{HLA-C allele 1}
#'   \item{C2}{HLA-C allele 2}
#'   \item{DRB11}{HLA-DRB1 allele 1}
#'   \item{DRB12}{HLA-DRB1 allele 2}
#'   ...
#' }
#' @source \url{https://12f11c1f-960a-f627-594d-b8ce276384f7.filesusr.com/ugd/3e838e_dc548dede99a4db5869c3d2c20c2d16f.pdf?index=true}
#' @concept data
"hla"


#' A pool of 10.0000 donors.
#'
#' A synthetic dataset with information for 10.000 donors, generated with `donors.df()` and `set.seed(3)` .
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{bg}{ABO blood group}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{DR1}{HLA-DRB1 allele 1}
#'   \item{DR2}{HLA-DRB1 allele 2}
#'   \item{age}{age in years}
#'   ...
#' }
#' @source \url{https://12f11c1f-960a-f627-594d-b8ce276384f7.filesusr.com/ugd/3e838e_dc548dede99a4db5869c3d2c20c2d16f.pdf?index=true}
#' @concept data
"D10K"


#' A vector with HLA-A.
#'
#' A character vector with antigens for HLA-A locus obtained from \code{hla} dataset.
#'
#' @format A character vector with length 20.
#' @concept data
"agA"

#' A vector with HLA-B.
#'
#' A character vector with antigens for HLA-B locus obtained from \code{hla} dataset.
#'
#' @format A character vector with length 34.
#' @concept data
"agB"

#' A vector with HLA-DR.
#'
#' A character vector with antigens for HLA-DR locus obtained from \code{hla} dataset.
#'
#' @format A character vector with length 13.
#' @concept data
"agDR"


#' NMDP HLA frequencies.
#'
#' A dataset containing Frequencies of HLA-A, -B, -DR haplotypes estimated (Expectation Maximization) by race/ethnicity from a subset of donors in the NMDP registry.
#'
#' @format A data frame with 8696 rows and 7 variables:
#' \describe{
#'   \item{A}{HLA-A allele}
#'   \item{B}{HLA-B allele}
#'   \item{DR}{HLA-DRB1 allele}
#'   \item{api}{haplotye frequencies for Asian / Pacific Islander}
#'   \item{afa}{haplotye frequencies for African American / Black}
#'   \item{cau}{haplotye frequencies for Withe Caucasian}
#'   \item{his}{haplotye frequencies for Hispanic}
#'   ...
#' }
#' @source \url{https://bioinformatics.bethematchclinical.org/hla-resources/haplotype-frequencies/a-b-drb1-224-haplotype-frequencies/}
#' @concept data
"MNDPhaps"

#' A vector with HLA-A from MNDP.
#'
#' A character vector with  HLA-A locus antigens, obtained from \code{MNDPhaps} dataset.
#'
#' @format A character vector with length 21.
#' @concept data
"agA_MNDP"

#' A vector with HLA-B from MNDP.
#'
#' A character vector with  HLA-B locus antigens, obtained from \code{MNDPhaps} dataset.
#'
#' @format A character vector with length 41.
#' @concept data
"agB_MNDP"

#' A vector with HLA-DR from MNDP.
#'
#' A character vector with  HLA-DR locus antigens, obtained from \code{MNDPhaps} dataset.
#'
#' @format A character vector with length 13.
#' @concept data
"agDR_MNDP"

#' A pool of 10.0000 donors API.
#'
#' A synthetic dataset with information for 10.000 donors, generated with \code{donors.df()} and \code{set.seed(3)} from MNDP's Asian / Pacific Islander population.
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{bg}{ABO blood group}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{DR1}{HLA-DRB1 allele 1}
#'   \item{DR2}{HLA-DRB1 allele 2}
#'   \item{age}{age in years}
#'   ...
#' }
#' @source \url{https://bioinformatics.bethematchclinical.org/hla-resources/haplotype-frequencies/a-b-drb1-224-haplotype-frequencies/}
#' @concept data
"D10K_API"

#' A pool of 10.0000 donors AFA.
#'
#' A synthetic dataset with information for 10.000 donors, generated with \code{donors.df()} and \code{set.seed(3)} from MNDP's African American / Black population.
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{bg}{ABO blood group}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{DR1}{HLA-DRB1 allele 1}
#'   \item{DR2}{HLA-DRB1 allele 2}
#'   \item{age}{age in years}
#'   ...
#' }
#' @source \url{https://bioinformatics.bethematchclinical.org/hla-resources/haplotype-frequencies/a-b-drb1-224-haplotype-frequencies/}
#' @concept data
"D10K_AFA"

#' A pool of 10.0000 donors CAU.
#'
#' A synthetic dataset with information for 10.000 donors, generated with \code{donors.df()} and \code{set.seed(3)} from MNDP's White / Caucasian population.
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{bg}{ABO blood group}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{DR1}{HLA-DRB1 allele 1}
#'   \item{DR2}{HLA-DRB1 allele 2}
#'   \item{age}{age in years}
#'   ...
#' }
#' @source \url{https://bioinformatics.bethematchclinical.org/hla-resources/haplotype-frequencies/a-b-drb1-224-haplotype-frequencies/}
#' @concept data
"D10K_CAU"

#' A pool of 10.0000 donors HIS.
#'
#' A synthetic dataset with information for 10.000 donors, generated with \code{donors.df()} and \code{set.seed(3)} from MNDP's Hispanic population.
#'
#' @format A data frame with 37993 rows and 9 variables:
#' \describe{
#'   \item{ID}{Identifier}
#'   \item{bg}{ABO blood group}
#'   \item{A1}{HLA-A allele 1}
#'   \item{A2}{HLA-A allele 2}
#'   \item{B1}{HLA-B allele 1}
#'   \item{B2}{HLA-B allele 2}
#'   \item{DR1}{HLA-DRB1 allele 1}
#'   \item{DR2}{HLA-DRB1 allele 2}
#'   \item{age}{age in years}
#'   ...
#' }
#' @source \url{https://bioinformatics.bethematchclinical.org/hla-resources/haplotype-frequencies/a-b-drb1-224-haplotype-frequencies/}
#' @concept data
"D10K_HIS"
