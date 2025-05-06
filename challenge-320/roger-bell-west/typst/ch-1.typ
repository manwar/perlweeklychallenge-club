#let maximumcount(a) = {
  let pos = 0
  let neg = 0
  for n in a {
    if n > 0 {
      pos += 1
    } else if n < 0 {
      neg += 1
    }
  }
  calc.max(pos, neg)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(maximumcount((-3, -2, -1, 1, 2, 3)) == 3)

Test 2:
    #testresult(maximumcount((-2, -1, 0, 0, 1)) == 2)

Test 3:
    #testresult(maximumcount((1, 2, 3, 4)) == 4)

