#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let rotx(a, offset) = {
  let o = calc.rem-euclid(offset, 26)
  let base;
  if a >= "a" and a <= "z" {
    base = "a".to-unicode()
  } else if a >= "A" and a <= "Z" {
    base = "A".to-unicode()
  } else {
    base = 0
  }
  let c = a
  if base > 0 {
    c = calc.rem-euclid(a.to-unicode() - base + o, 26) + base
  }
  str.from-unicode(c)
}

#let encryptedstring(a, offset) = {
  a.codepoints().map(x => rotx(x, offset)).join("")
}

Test 1:
    #testresult(encryptedstring("abc", 1) == "bcd")

Test 2:
    #testresult(encryptedstring("xyz", 2) == "zab")

Test 3:
    #testresult(encryptedstring("abc", 27) == "bcd")

Test 4:
    #testresult(encryptedstring("hello", 5) == "mjqqt")

Test 5:
    #testresult(encryptedstring("perl", 26) == "perl")

