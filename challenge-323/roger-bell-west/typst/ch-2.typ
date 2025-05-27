#let taxamount(income, brackets) = {
  let tax = 0
  let lastbracket = 0
  for bracket in brackets {
    if income > lastbracket {
      tax += (calc.min(income, bracket.at(0)) - lastbracket) * bracket.at(1)
    }
    lastbracket = bracket.at(0)
  }
  float(tax) / 100.0
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(taxamount(10, ((3, 50), (7, 10), (12, 25))) == 2.65)

Test 2:
    #testresult(taxamount(2, ((1, 0), (4, 25), (5, 50))) == 0.25)

Test 3:
    #testresult(taxamount(0, ((2, 50),)) == 0)

