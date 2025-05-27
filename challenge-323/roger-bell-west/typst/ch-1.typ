#let incrementdecrement(operations) = {
  let p = 0
  for s in operations {
    if s.at(1) == "+" {
      p += 1
    } else {
      p -= 1
    }
  }
  p
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(incrementdecrement(("--x", "x++", "x++")) == 1)

Test 2:
    #testresult(incrementdecrement(("x++", "++x", "x++")) == 3)

Test 3:
    #testresult(incrementdecrement(("x++", "++x", "--x", "x--")) == 0)

