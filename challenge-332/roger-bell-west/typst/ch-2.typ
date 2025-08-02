#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let counterify(a) = {
  let c = (:)
  for n in a {
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let oddletters(a) = {
  let c = counterify(a.clusters())
  c.values().all(calc.odd)
}

Test 1:
    #testresult(not oddletters("weekly"))

Test 2:
    #testresult(oddletters("perl"))

Test 3:
    #testresult(not oddletters("challenge"))

