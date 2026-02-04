#let digitalroot(a) = {
  let count = 0
  let value = int(a)
  while value > 9 {
    let p = 0
    while value > 0 {
      p += calc.rem-euclid(value, 10)
      value = calc.div-euclid(value, 10)
    }
    value = p
    count += 1
  }
  (count, value)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(digitalroot(38) == (2, 2))

Test 2:
    #testresult(digitalroot(7) == (0, 7))

Test 3:
    #testresult(digitalroot(999) == (2, 9))

Test 4:
    #testresult(digitalroot(1999999999) == (3, 1))

Test 5:
    #testresult(digitalroot(101010) == (1, 3))

