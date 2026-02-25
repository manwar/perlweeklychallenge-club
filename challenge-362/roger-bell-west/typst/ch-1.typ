#let echochamber(a) = {
  let out = ""
  for (i, c) in a.codepoints().enumerate() {
    for _ in range(i + 1) {
      out += c
    }
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
    #testresult(echochamber("abca") == "abbcccaaaa")

Test 2:
    #testresult(echochamber("xyz") == "xyyzzz")

Test 3:
    #testresult(echochamber("code") == "coodddeeee")

Test 4:
    #testresult(echochamber("hello") == "heelllllllooooo")

Test 5:
    #testresult(echochamber("a") == "a")

