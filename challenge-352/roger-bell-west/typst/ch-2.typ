#let binaryprefix(a) = {
  let c = 0
  let out = ()
  for n in a {
    c *= 2
    c += n
    out.push(calc.rem-euclid(c, 5) == 0)
  }
  out
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(binaryprefix((0, 1, 1, 0, 0, 1, 0, 1, 1, 1)) == (true, false, false, false, false, true, true, false, false, false))

Test 2:
    #testresult(binaryprefix((1, 0, 1, 0, 1, 0)) == (false, false, true, true, false, false))

Test 3:
    #testresult(binaryprefix((0, 0, 1, 0, 1)) == (true, true, false, false, true))

Test 4:
    #testresult(binaryprefix((1, 1, 1, 1, 1)) == (false, false, false, true, false))

Test 5:
    #testresult(binaryprefix((1, 0, 1, 1, 0, 1, 0, 0, 1, 1)) == (false, false, true, false, false, true, true, true, false, false))

