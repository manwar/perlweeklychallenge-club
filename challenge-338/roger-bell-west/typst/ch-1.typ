#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let highestrow(a) = {
  calc.max(..a.map(x => x.sum()))
}

Test 1:
    #testresult(highestrow(((4, 4, 4, 4), (10, 0, 0, 0), (2, 2, 2, 9))) == 16)

Test 2:
    #testresult(highestrow(((1, 5), (7, 3), (3, 5))) == 10)

Test 3:
    #testresult(highestrow(((1, 2, 3), (3, 2, 1))) == 6)

Test 4:
    #testresult(highestrow(((2, 8, 7), (7, 1, 3), (1, 9, 5))) == 17)

Test 5:
    #testresult(highestrow(((10, 20, 30), (5, 5, 5), (0, 100, 0), (25, 25, 25))) == 100)

