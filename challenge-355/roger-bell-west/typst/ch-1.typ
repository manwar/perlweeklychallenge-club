#let thousandseparator(a) = {
  let out = ""
  let s = str(a)
  let offset = 2 - calc.rem-euclid(s.len() + 2, 3)
  for (i, d) in s.codepoints().enumerate() {
    if i > 0 and calc.rem-euclid(i + offset, 3) == 0 {
      out += ","
    }
    out += d
  }
  out
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(thousandseparator(123) == "123")

Test 2:
    #testresult(thousandseparator(1234) == "1,234")

Test 3:
    #testresult(thousandseparator(1000000) == "1,000,000")

Test 4:
    #testresult(thousandseparator(1) == "1")

Test 5:
    #testresult(thousandseparator(12345) == "12,345")

