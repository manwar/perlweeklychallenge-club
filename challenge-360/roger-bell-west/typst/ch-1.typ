#let textjustifier(intxt, width) = {
  let working = ()
  for i in range(width) {
    working.push("*")
  }
  let offset = int((width - intxt.len()) / 2)
  for (i, c) in intxt.codepoints().enumerate() {
    working.at(i + offset) = c
  }
  working.join("")
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(textjustifier("Hi", 5) == "*Hi**")

Test 2:
    #testresult(textjustifier("Code", 10) == "***Code***")

Test 3:
    #testresult(textjustifier("Hello", 9) == "**Hello**")

Test 4:
    #testresult(textjustifier("Perl", 4) == "Perl")

Test 5:
    #testresult(textjustifier("A", 7) == "***A***")

Test 6:
    #testresult(textjustifier("", 5) == "*****")

