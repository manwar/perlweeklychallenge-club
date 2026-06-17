#let l2n(a) = {
  let a0 = "a".to-unicode()
  let t = 0
  for c in a {
    t *= 10
    t += c.to-unicode() - a0
  }
  t
}

#let sumofwords(a, b, c) = {
  l2n(a) + l2n(b) == l2n(c)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(sumofwords("acb", "cba", "cdb"))

Test 2:
    #testresult(sumofwords("aab", "aac", "ad"))

Test 3:
    #testresult(not sumofwords("bc", "je", "jg"))

Test 4:
    #testresult(sumofwords("a", "aaaa", "aa"))

Test 5:
    #testresult(not sumofwords("c", "d", "h"))

Test 6:
    #testresult(sumofwords("gfi", "hbf", "bdhd"))

