#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let maxdistance(a, b) = {
    let l1 = calc.min(..a)
    let h1 = calc.max(..a)
    let l2 = calc.min(..b)
    let h2 = calc.max(..b)
    calc.max(h1 - l2, h2 - l1)
}

Test 1:
    #testresult(maxdistance((4, 5, 7), (9, 1, 3, 4)) == 6)

Test 2:
    #testresult(maxdistance((2, 3, 5, 4), (3, 2, 5, 5, 8, 7)) == 6)

Test 3:
    #testresult(maxdistance((2, 1, 11, 3), (2, 5, 10, 2)) == 9)

Test 4:
    #testresult(maxdistance((1, 2, 3), (3, 2, 1)) == 2)

Test 5:
    #testresult(maxdistance((1, 0, 2, 3), (5, 0)) == 5)

