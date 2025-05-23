#let arr2set(a) = {
  a.map(x => (str(x), true)).to-dict()
}

#let rankarray(a) = {
  let b = arr2set(a).keys().map(x => int(x)).sorted()
  let c = ().to-dict()
  for (i, n) in b.enumerate() {
    c.insert(str(n), i + 1)
  }
  let out = ()
  for v in a {
    out.push(c.at(str(v)))
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
    #testresult(rankarray((55, 22, 44, 33)) == (4, 1, 3, 2))

Test 2:
    #testresult(rankarray((10, 10, 10)) == (1, 1, 1))

Test 3:
    #testresult(rankarray((5, 1, 1, 4, 3)) == (4, 1, 1, 3, 2))
