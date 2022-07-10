test_that("ABO blood group vector", {
  expect_equal(abo(n = 5, probs = c(0.4658, 0.0343, 0.077, 0.4229), seed.number = 123), c("A", "O", "A", "O", "B"))
})

test_that("eGFR by age", {
  expect_equal(round(aGFR(age = 43, seed.number = 123),0), 95)
})

test_that("vector with cPRA values", {
  expect_equal(sum(cpra(n = 5, probs = c(0.7, 0.1, 0.1, 0.1), seed.number = 123)), 0)
})

test_that("time on dialysis", {
  expect_equal(dial(hiper = F, bg = 'A', seed.number = 1), 22)
})

