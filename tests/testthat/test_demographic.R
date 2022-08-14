test_that("Ages", {
  expect_equal(ages(n = 1, mean = 20, sd = 10),
               36)
  expect_equal(ages(n = 1, mean = 25, sd = 13),
               22)
  expect_equal(ages(n = 5, mean = 20, sd = 10, seed.number = 1),
               c(22,36,23,25,27))
  expect_equal(ages(n = 5, mean = 25, sd = 13, seed.number = 1),
               c(27,46,29,31,35))
  expect_equal(ages(n = 1, lower=50, upper=60, mean = 20, sd = 10),
               53)
  expect_equal(ages(n = 1, lower=40, upper=50, mean = 25, sd = 13),
               40)

  invalid.numbers <- list(-1,'0','x','1',-10)
  for(i in 1:invalid.numbers){
    expect_error(ages(n = invalid.numbers[[i]]))
    expect_error(ages(lower = invalid.numbers[[i]]))
    expect_error(ages(upper = invalid.numbers[[i]]))
    expect_error(ages(mean = invalid.numbers[[i]]))
    expect_error(ages(sd = invalid.numbers[[i]]))
    }
})
