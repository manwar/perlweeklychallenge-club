#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let brokenkeyboard(a, b) = {
  let bk = (:)
  for c in b {
    bk.insert(lower(c), true)
  }
  let ct = 0
  for w in lower(a).split(" ") {
    let nk = (:)
    for c in w {
      nk.insert(c, true)
    }
    if nk.keys().filter(k => k in bk).len() == 0 {
      ct += 1
    }
  }
  ct
}
Test 1:
    #testresult(brokenkeyboard("Hello World", ("d")) == 1)

Test 2:
    #testresult(brokenkeyboard("apple banana cherry", ("a", "e")) == 0)

Test 3:
    #testresult(brokenkeyboard("Coding is fun", ()) == 3)

Test 4:
    #testresult(brokenkeyboard("The Weekly Challenge", ("a", "b")) == 2)

Test 5:
    #testresult(brokenkeyboard("Perl and Python", ("p")) == 1)

