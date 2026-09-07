#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let zigzagsubarray(a) = {
  let mx = calc.min(a.len(), 1)
  for i in range(a.len()) {
    let o = 0
    let lastdir = 0
    for j in range(i, a.len()) {
      let thisdir = 0
      if j > i {
        if a.at(j) > o {
          thisdir = 1
          mx = calc.max(mx, 2)
        } else if a.at(j) < o {
          thisdir = -1
          mx = calc.max(mx, 2)
        }
      }
      if (j > i and thisdir == 0) or (j > i + 1 and thisdir * lastdir != -1) {
        break
      }
      o = a.at(j)
      lastdir = thisdir
      mx = calc.max(mx, j - i + 1)
    }
  }
  mx
}

Test 1:
    #testresult(zigzagsubarray((9, 4, 2, 10, 7, 8, 8, 1, 9)) == 5)

Test 2:
    #testresult(zigzagsubarray((1, 7, 4, 9, 2, 5)) == 6)

Test 3:
    #testresult(zigzagsubarray((1, 2, 3, 4, 5)) == 2)

Test 4:
    #testresult(zigzagsubarray((4, 4, 4)) == 1)

Test 5:
    #testresult(zigzagsubarray((10, 20, 15, 12, 18)) == 3)

