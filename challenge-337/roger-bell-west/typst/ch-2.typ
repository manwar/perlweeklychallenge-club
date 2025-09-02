#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let oddmatrix(rows, cols, points) = {
  let rm = (:)
  let cm = (:)
  for p in points {
    let p0 = str(p.at(0))
    let p1 = str(p.at(1))
    if p0 in rm {
      let _ = rm.remove(p0)
    } else {
      rm.insert(p0, true)
    }
    if p1 in cm {
      let _ = cm.remove(p1)
    } else {
      cm.insert(p1, true)
    }
  }
  rm.len() * (cols - cm.len()) + cm.len() * (rows - rm.len())
}

Test 1:
    #testresult(oddmatrix(2, 3, ((0, 1), (1, 1))) == 6)

Test 2:
    #testresult(oddmatrix(2, 2, ((1, 1), (0, 0))) == 0)

Test 3:
    #testresult(oddmatrix(3, 3, ((0, 0), (1, 2), (2, 1))) == 0)

Test 4:
    #testresult(oddmatrix(1, 5, ((0, 2), (0, 4))) == 2)

Test 5:
    #testresult(oddmatrix(4, 2, ((1, 0), (3, 1), (2, 0), (0, 1))) == 8)

