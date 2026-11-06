#let divisibleaverage(a) = {
    let b = a.filter(x => calc.rem-euclid(x, 6) == 0)
    if b.len() == 0 {
        0
    } else {
        int(float(b.sum()) / float(b.len()) + 0.5)
    }
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(divisibleaverage((18, 5, 7, 11)) == 18)

Test 2:
    #testresult(divisibleaverage((6, 12, 18, 24, 30, 40)) == 18)

Test 3:
    #testresult(divisibleaverage((3, 9, 15, 21, 27)) == 0)

Test 4:
    #testresult(divisibleaverage((6, 12, 14, 20)) == 9)

Test 5:
    #testresult(divisibleaverage((6, 6, 6, 12, 12)) == 8)

