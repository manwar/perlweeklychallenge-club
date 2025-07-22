#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let lastword(a) = {
  let w = a.split(" ").filter(x => x.len() > 0)
  w.at(w.len() - 1).len()
}

Test 1:
    #testresult(lastword("The Weekly Challenge") == 9)

Test 2:
    #testresult(lastword("   Hello   World    ") == 5)

Test 3:
    #testresult(lastword("Let's begin the fun") == 3)

