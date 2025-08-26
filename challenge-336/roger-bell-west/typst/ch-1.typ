#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let counterify(a) = {
  let c = (:)
  for nn in a {
    let n = str(nn)
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let arr2set(a) = {
  a.map(x => (str(x), true)).to-dict()
}

#let equalgroup(a) = {
  let s = counterify(a)
  let v = arr2set(s.values()).keys().map(c => int(c))
  let l = calc.min(.. v)
  if l < 2 {
    false
  } else {
    let ret = false
    for t in range(2, l + 1) {
      if v.all(c => calc.rem-euclid(c, t) == 0) {
        ret = true
        break
      }
    }
    ret
  }
}

Test 1:
    #testresult(equalgroup((1, 1, 2, 2, 2, 2)))

Test 2:
    #testresult(not equalgroup((1, 1, 1, 2, 2, 2, 3, 3)))

Test 3:
    #testresult(equalgroup((5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7)))

Test 4:
    #testresult(not equalgroup((1, 2, 3, 4)))

Test 5:
    #testresult(equalgroup((8, 8, 9, 9, 10, 10, 11, 11)))

