test_that("data frame with NMDP HLA haplotypes",{

  invalid.origin <- list('p',0,1,'us','api','afa','c', 'PT')
  for(i in 1:length(invalid.origin)){
    expect_error(hla_sample_mndp(origin = invalid.origin[[i]]))
  }
})

test_that("data frame with HLA haplotypes",{

  invalid.origin <- list('p',0,1,'us','api','afa','c', 'PT')
  for(i in 1:length(invalid.origin)){
    expect_error(hla_sample(origin = invalid.origin[[i]]))
  }

  expect_error(
    hla_sample(n = -1)
  )
  expect_error(
    hla_sample(n = 'x')
  )
  expect_error(
    hla_sample(replace = 0)
  )
  expect_error(
    hla_sample(replace = 'x')
  )


})


test_that("ABO blood group vector", {
  expect_equal(abo(n = 5, probs = c(0.4658, 0.0343, 0.077, 0.4229), seed.number = 123),
               c("A", "O", "A", "O", "B"))

  expect_error(
    abo(n = -1)
  )
  expect_error(
    abo(n = 'x')
  )

  expect_error(
    abo(seed.number = -1)
  )
  expect_error(
    abo(seed.number = 'x')
  )
  expect_error(abo(probs = c(1,1,1,1)))
  expect_error(abo(probs = c(0.5,0.25,0.25)))


})

test_that("eGFR by age", {
  expect_equal(round(aGFR(age = 43, seed.number = 123),0),
               95)
  expect_error(aGFR(age = -1))
  expect_error(aGFR(age = 'x'))
  expect_error(aGFR(age = 1000))
  expect_error(aGFR(age = 0))
})

test_that("vector with cPRA values", {
  expect_equal(sum(cpra(n = 5, probs = c(0.7, 0.1, 0.1, 0.1), seed.number = 123)),
               0)

  expect_error(cpra(n = -1))
  expect_error(cpra(n = 'x'))
  expect_error(cpra(probs = c(1,1,1,1)))
  expect_error(cpra(probs = c(0.5,0.25,0.25)))
})

test_that("time on dialysis", {
  expect_equal(dial(hiper = F, bg = 'A', seed.number = 1),
               22)

  expect_error(dial(bg = 'x'))
  expect_error(dial(bg = 0))
  expect_error(dial(hiper = 'x'))
  expect_error(dial(hiper = 1))
})

