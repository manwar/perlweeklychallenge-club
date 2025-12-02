#let counterify(a) = {
  let c = (:)
  for nn in a {
    let n = str(nn)
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let goodsubstrings(a) = {
  let p = 0
  for s in a.codepoints().windows(3) {
    let c = counterify(s)
    if calc.max(..c.values()) == 1 {
      p += 1
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
    #testresult(goodsubstrings("abcaefg") == 5)

Test 2:
    #testresult(goodsubstrings("xyzzabc") == 3)

Test 3:
    #testresult(goodsubstrings("aababc") == 1)

Test 4:
    #testresult(goodsubstrings("qwerty") == 4)

Test 5:
    #testresult(goodsubstrings("zzzaaa") == 0)

