#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let arraymedian(a, b) = {
  let nn = a
  for n in b {
    nn.push(n)
  }
  nn = nn.sorted()
  let i = calc.div-euclid(nn.len(), 2)
  if calc.rem-euclid(nn.len(), 2) == 0 {
    float(nn.at(i - 1) + nn.at(i)) / 2.0
   } else {
    float(nn.at(i))
   }
}

Test 1:
    #testresult(arraymedian((2,), (4,)) == 3)

Test 2:
    #testresult(arraymedian((1, 2, 3), (7, 8, 9, 10)) == 7)

Test 3:
    #testresult(arraymedian((), (10, 20, 30, 40)) == 25)

Test 4:
    #testresult(arraymedian((100,), (1, 2, 3, 4, 5, 6, 7)) == 4.5)

Test 5:
    #testresult(arraymedian((1, 2, 2), (2, 2, 3)) == 2)

