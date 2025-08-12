#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let rangesum(a, s, e) = {
  a.slice(s, e + 1).sum()
}

Test 1:
    #testresult(rangesum((-2, 0, 3, -5, 2, -1), 0, 2) == 1)

Test 2:
    #testresult(rangesum((1, -2, 3, -4, 5), 1, 3) == -3)

Test 3:
    #testresult(rangesum((1, 0, 2, -1, 3), 3, 4) == 2)

Test 4:
    #testresult(rangesum((-5, 4, -3, 2, -1, 0), 0, 3) == -2)

Test 5:
    #testresult(rangesum((-1, 0, 2, -3, -2, 1), 0, 2) == 1)

