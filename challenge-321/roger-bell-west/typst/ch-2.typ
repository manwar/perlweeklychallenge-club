#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let backspacecompare(a, b) = {
  let sa = ()
  for i in (a, b) {
    let oa = ()
    for c in i {
      if c == "#" {
        let _ = oa.pop()
      } else {
        oa.push(c)
      }
    }
    sa.push(oa.join(none))
  }
  sa.at(0) == sa.at(1)
}

Test 1:
    #testresult(backspacecompare("ab#c", "ad#c"))

Test 2:
    #testresult(backspacecompare("ab##", "a#b#"))

Test 3:
    #testresult(not backspacecompare("a#b", "c"))

