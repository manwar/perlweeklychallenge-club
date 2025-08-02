#let sumdifference(a) = {
  let delta = 0
  for x in a {
    if x >= 10 {
      let digitsum = 0
      let xa = x
      while xa > 0 {
        digitsum += calc.rem-euclid(xa, 10)
        xa = calc.div-euclid(xa, 10)
      }
      delta += x - digitsum
    }
  }
  delta
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(sumdifference((1, 23, 4, 5)) == 18)

Test 2:
    #testresult(sumdifference((1, 2, 3, 4, 5)) == 0)

Test 3:
    #testresult(sumdifference((1, 2, 34)) == 27)

