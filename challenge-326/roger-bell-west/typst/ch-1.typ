#let dayoftheyear(a) = {
  let c = a.match(regex("([0-9]{4})-([0-9]{2})-([0-9]{2})")).captures
  let d = datetime(year: int(c.at(0)), month: int(c.at(1)), day: int(c.at(2)))
  d.ordinal()
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(dayoftheyear("2025-02-02") == 33)

Test 2:
    #testresult(dayoftheyear("2025-04-10") == 100)

Test 3:
    #testresult(dayoftheyear("2025-09-07") == 250)

