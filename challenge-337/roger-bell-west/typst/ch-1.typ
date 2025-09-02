#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let smallerthancurrent(a) = {
  let b = a.sorted()
  let m = (:)
  for (i, v) in b.enumerate() {
    let vs = str(v)
    if not vs in m {
      m.insert(vs, i)
    }
  }
  a.map(x => int(m.at(str(x))))
}

Test 1:
    #testresult(smallerthancurrent((6, 5, 4, 8)) == (2, 1, 0, 3))

Test 2:
    #testresult(smallerthancurrent((7, 7, 7, 7)) == (0, 0, 0, 0))

Test 3:
    #testresult(smallerthancurrent((5, 4, 3, 2, 1)) == (4, 3, 2, 1, 0))

Test 4:
    #testresult(smallerthancurrent((-1, 0, 3, -2, 1)) == (1, 2, 4, 0, 3))

Test 5:
    #testresult(smallerthancurrent((0, 1, 1, 2, 0)) == (0, 2, 2, 4, 0))

