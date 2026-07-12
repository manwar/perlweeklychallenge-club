#let smallergreaterelement(a) = {
  let mn = calc.min(..a)
  let mx = calc.max(..a)
  a.filter(x => x > mn and x < mx).len()
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(smallergreaterelement((2, 4)) == 0)

Test 2:
    #testresult(smallergreaterelement((1, 1, 1, 1)) == 0)

Test 3:
    #testresult(smallergreaterelement((1, 1, 4, 8, 12, 12)) == 2)

Test 4:
    #testresult(smallergreaterelement((3, 6, 6, 9)) == 2)

Test 5:
    #testresult(smallergreaterelement((0, -5, 10, -2, 4)) == 3)

