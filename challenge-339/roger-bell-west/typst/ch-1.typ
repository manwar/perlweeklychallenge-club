#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let maxdiff(a) = {
  let md = 0
  for w in range(a.len() - 1) {
    for x in range(w + 1, a.len()) {
      for y in range(w + 1, a.len() - 1) {
        if y != x {
          for z in range(y + 1, a.len()) {
            if z != x {
              let v = calc.abs(a.at(w) * a.at(x) - a.at(y) * a.at(z))
              md = calc.max(md, v)
            }
          }
        }
      }
    }
  }
  md
}

Test 1:
    #testresult(maxdiff((5, 9, 3, 4, 6)) == 42)

Test 2:
    #testresult(maxdiff((1, -2, 3, -4)) == 10)

Test 3:
    #testresult(maxdiff((-3, -1, -2, -4)) == 10)

Test 4:
    #testresult(maxdiff((10, 2, 0, 5, 1)) == 50)

Test 5:
    #testresult(maxdiff((7, 8, 9, 10, 10)) == 44)

