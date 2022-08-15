test_that("number of HLA mm", {
  expect_equal(mmHLA(dA = c('1','2'), dB = c('5','7'), dDR = c('1','4'),
                     cA = c('1','2'), cB = c('3','15'), cDR = c('4','7')),
               c(mmA = 0, mmB = 2, mmDR = 1, mmHLA = 3))
  expect_equal(mmHLA(dA = c('1','2'), dB = c('5','7'), dDR = c('4','4'),
                     cA = c('3','4'), cB = c('5','15'), cDR = c('4','7')),
               c(mmA = 2, mmB = 1, mmDR = 0, mmHLA = 3))
  expect_equal(mmHLA()["mmHLA"][[1]],
               (mmHLA()["mmA"] + mmHLA()["mmB"] + mmHLA()["mmDR"])[[1]])

  expect_error(mmHLA(dA = c(1,2)))
  expect_error(mmHLA(dB = c(1,2)))
  expect_error(mmHLA(dDR = c(1,2)))
  expect_error(mmHLA(cA = c(1,2)))
  expect_error(mmHLA(cB = c(1,2)))
  expect_error(mmHLA(dcDR = c(1,2)))
})

test_that("Matchability from D10K", {
  expect_equal(matchability(cABO = 'A', cPRA = 85, seed.number = 3),
               67)
  expect_equal(matchability(cABO = 'B', cPRA = 85, seed.number = 3),
               10)
  expect_equal(matchability(cABO = 'AB', cPRA = 50, seed.number = 1),
               13)
  expect_equal(matchability(cABO = 'O', cPRA = 0, seed.number = 1),
               395)

  invalid.ABO <- list(0, 'X', 'a', 'o', 'b')
  for(i in 1:length(invalid.ABO)){
  expect_error(matchability(cABO = invalid.ABO[[i]]))
  }
})

test_that("virtual PRA", {
  expect_equal(vpra(abs = c('A1','A2','B5','DR4'), donors = D10K),
               70)
  expect_equal(vpra(abs = c('A11','A30','DR8'), donors = D10K),
               24.7)
  expect_equal(vpra(abs = c('DR13'), donors = D10K),
               28.5)
  expect_equal(vpra(abs = c('A29'), donors = D10K),
               10.9)
})

test_that("HLA antibodies", {
  expect_equal(antbs(cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
                     cPRA = 85,
                     origin = 'PT', seed.number = 3)$vPRA,
               82.8)
  expect_equal(antbs(cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
                     cPRA = 50,
                     origin = 'PT', seed.number = 1)$vPRA,
               50.1)
  expect_equal(antbs(cA = c('2','29'), cB = c('7','15'), cDR = c('4','7'),
                     cPRA = 50,
                     origin = 'PT', seed.number = 1)$Abs,
               c("DR15","A24","B53","A1"))

  invalid.origin <- list('p',0,1,'us','api','afa','c')
  for(i in 1:length(invalid.origin)){
    expect_error(antbs(origin = invalid.origin[[i]]))
    }
})
