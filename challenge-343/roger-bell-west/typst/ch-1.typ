#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let zerofriend(a) = {
  let b = calc.min(..a.map(x => calc.abs(x)))
  if a.contains(b) {
    b
  } else {
    -b
  }
}

Test 1:
    #testresult(zerofriend((4, 2, -1, 3, -2)) == -1)

Test 2:
    #testresult(zerofriend((-5, 5, -3, 3, -1, 1)) == 1)

Test 3:
    #testresult(zerofriend((7, -3, 0, 2, -8)) == 0)

Test 4:
    #testresult(zerofriend((-2, -5, -1, -8)) == -1)

Test 5:
    #testresult(zerofriend((-2, 2, -4, 4, -1, 1)) == 1)

