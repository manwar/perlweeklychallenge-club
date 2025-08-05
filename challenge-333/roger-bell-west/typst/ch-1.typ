#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let straightline(a) = {
  let b = a.dedup()
  if b.len() < 3 {
    return true
  }
  let p = b.at(0).at(1)
  let q = b.at(1).at(0) - b.at(0).at(0)
  let r = b.at(0).at(1)
  let s = b.at(1).at(1) - b.at(0).at(1)
  for tpair in range(2, b.len()).map(n => b.at(n)) {
     if q == 0. and tpair.at(0) != b.at(0).at(0) {
      return false
    }
    if s == 0. and tpair.at(1) != b.at(0).at(1) {
      return false
    }
    if q != 0. and s != 0. {
      let n1 = (tpair.at(0) - p) / q
      let n2 = (tpair.at(1) - r) / s
      if n1 != n2 {
        return false
      }
    }
  }
  true
}

Test 1:
    #testresult(straightline(((2, 1), (2, 3), (2, 5))))

Test 2:
    #testresult(straightline(((1, 4), (3, 4), (10, 4))))

Test 3:
    #testresult(not straightline(((0, 0), (1, 1), (2, 3))))

Test 4:
    #testresult(straightline(((1, 1), (1, 1), (1, 1))))

