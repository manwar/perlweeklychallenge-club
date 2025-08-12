#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let nearestvalidpoint(x, y, points) = {
  let ix = -1
  let minmhd = -1
  for (i, p) in points.enumerate() {
    if p.at(0) == x or p.at(1) == y {
      let mhd = calc.abs(p.at(0) - x) + calc.abs(p.at(1) - y)
      if minmhd == -1 or mhd < minmhd {
        minmhd = mhd
        ix = i
      }
    }
  }
  ix
}

Test 1:
    #testresult(nearestvalidpoint(3, 4, ((1, 2), (3, 1), (2, 4), (2, 3))) == 2)

Test 2:
    #testresult(nearestvalidpoint(2, 5, ((3, 4), (2, 3), (1, 5), (2, 5))) == 3)

Test 3:
    #testresult(nearestvalidpoint(1, 1, ((2, 2), (3, 3), (4, 4))) == -1)

Test 4:
    #testresult(nearestvalidpoint(0, 0, ((0, 1), (1, 0), (0, 2), (2, 0))) == 0)

Test 5:
    #testresult(nearestvalidpoint(5, 5, ((5, 6), (6, 5), (5, 4), (4, 5))) == 0)

