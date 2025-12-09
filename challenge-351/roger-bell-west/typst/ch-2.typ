#let arithmeticprogression(a0) = {
  let epsilon = 0.0001
  let a = a0.sorted()
  let delta = a.at(1) - a.at(0)
  let r = true
  for v in a.slice(1).windows(2) {
    if calc.abs(v.at(1) - v.at(0) - delta) > epsilon {
      r = false
      break
    }
  }
  r
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(arithmeticprogression((1.0, 3.0, 5.0, 7.0, 9.0)))

Test 2:
    #testresult(arithmeticprogression((9.0, 1.0, 7.0, 5.0, 3.0)))

Test 3:
    #testresult(not arithmeticprogression((1.0, 2.0, 4.0, 8.0, 16.0)))

Test 4:
    #testresult(arithmeticprogression((5.0, -1.0, 3.0, 1.0, -3.0)))

Test 5:
    #testresult(arithmeticprogression((1.5, 3, 0.0, 4.5, 6.0)))

