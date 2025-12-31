#let shiftgrid(gi, k0) = {
  let wi = gi.flatten()
  let k = calc.rem-euclid(k0, wi.len())
  let wo = wi.slice(wi.len() - k) + wi.slice(0, wi.len() - k)
  wo.chunks(gi.at(0).len())
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(shiftgrid(((1, 2, 3), (4, 5, 6), (7, 8, 9)), 1) == ((9, 1, 2), (3, 4, 5), (6, 7, 8)))

Test 2:
    #testresult(shiftgrid(((10, 20), (30, 40)), 1) == ((40, 10), (20, 30)))

Test 3:
    #testresult(shiftgrid(((1, 2), (3, 4), (5, 6)), 1) == ((6, 1), (2, 3), (4, 5)))

Test 4:
    #testresult(shiftgrid(((1, 2, 3), (4, 5, 6)), 5) == ((2, 3, 4), (5, 6, 1)))

Test 5:
    #testresult(shiftgrid(((1, 2, 3, 4),), 1) == ((4, 1, 2, 3),))

