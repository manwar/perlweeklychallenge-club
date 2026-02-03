#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let strvalue(a) = {
  if regex("^[0-9]+$") in a {
    return int(a)
  }
  a.len()
}

#let maxstrvalue(a) = {
  calc.max(..a.map(x => strvalue(x)))
}

Test 1:
    #testresult(maxstrvalue(("123", "45", "6")) == 123)

Test 2:
    #testresult(maxstrvalue(("abc", "de", "fghi")) == 4)

Test 3:
    #testresult(maxstrvalue(("0012", "99", "a1b2c")) == 99)

Test 4:
    #testresult(maxstrvalue(("x", "10", "xyz", "007")) == 10)

Test 5:
    #testresult(maxstrvalue(("hello123", "2026", "perl")) == 2026)

