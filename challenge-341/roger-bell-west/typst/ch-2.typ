#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let reverseprefix(a, f) = {
  let c = a.codepoints()
  let p = a.position(f)
  if p != none {
    let jr = c.slice(0, p + 1).rev()
    for (i, ch) in jr.enumerate() {
      c.at(i) = ch
    }
  }
  c.join(none)
}

Test 1:
    #testresult(reverseprefix("programming", "g") == "gorpramming")

Test 2:
    #testresult(reverseprefix("hello", "h") == "hello")

Test 3:
    #testresult(reverseprefix("abcdefghij", "h") == "hgfedcbaij")

Test 4:
    #testresult(reverseprefix("reverse", "s") == "srevere")

Test 5:
    #testresult(reverseprefix("perl", "r") == "repl")

