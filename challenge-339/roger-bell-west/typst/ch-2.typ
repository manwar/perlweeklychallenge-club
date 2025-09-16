#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let peakpoint(a) = {
  let h = 0
  let o = 0
  for p in a {
    h += p
    o = calc.max(o, h)
  }
  o
}

Test 1:
    #testresult(peakpoint((-5, 1, 5, -9, 2)) == 1)

Test 2:
    #testresult(peakpoint((10, 10, 10, -25)) == 30)

Test 3:
    #testresult(peakpoint((3, -4, 2, 5, -6, 1)) == 6)

Test 4:
    #testresult(peakpoint((-1, -2, -3, -4)) == 0)

Test 5:
    #testresult(peakpoint((-10, 15, 5)) == 10)

