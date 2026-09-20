#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let arrangebox(a0) = {
  let a = a0.sorted(by: (aa, bb) => (aa.at(0) < bb.at(0) or aa.at(1) < bb.at(1)))
  let stack = ()
  let mx = 1
  for i in range(a.len()) {
     stack.push((i, 1))
  }
  while stack.len() > 0 {
    let (ix, pm) = stack.pop()
    if pm > mx {
      mx = pm
    }
    for j in range(ix + 1, a.len()) {
      if a.at(ix).at(0) < a.at(j).at(0) and a.at(ix).at(1) < a.at(j).at(1) {
        stack.push((j, pm + 1))
      }
    }
  }
  mx
}

Test 1:
    #testresult(arrangebox(((1, 3), (3, 5), (6, 8), (2, 4))) == 4)

Test 2:
    #testresult(arrangebox(((4, 5), (4, 6), (6, 7), (2, 3), (4, 3))) == 3)

Test 3:
    #testresult(arrangebox(((5, 5), (5, 5), (5, 5))) == 1)

Test 4:
    #testresult(arrangebox(((2, 100), (3, 200), (4, 300), (5, 50), (5, 400))) == 4)

Test 5:
    #testresult(arrangebox(((10, 20), (15, 10), (20, 30), (12, 18), (16, 25))) == 3)

