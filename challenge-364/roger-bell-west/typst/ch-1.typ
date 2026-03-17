#let decryptstring(a) = {
  let out = ""
  let s = 0
  while s < a.len() {
    let m = int(a.at(s))
    if s + 2 < a.len() and a.at(s + 2) == "#" {
      m = m * 10 + int(a.at(s + 1))
      s += 2
    }
    s += 1
    out += str.from-unicode(96 + m)
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
    #testresult(decryptstring("10#11#12") == "jkab")

Test 2:
    #testresult(decryptstring("1326#") == "acz")

Test 3:
    #testresult(decryptstring("25#24#123") == "yxabc")

Test 4:
    #testresult(decryptstring("20#5") == "te")

Test 5:
    #testresult(decryptstring("1910#26#") == "aijz")

