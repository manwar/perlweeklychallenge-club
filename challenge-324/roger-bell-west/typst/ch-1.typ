#let twodarray(i, r, c) = {
  let out = ()
  for (ct, n) in i.enumerate() {
    if calc.rem-euclid(ct, c) == 0 {
      out.push(())
    }
    let ol = out.len() - 1
    out.at(ol).push(n)
  }
  out
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(twodarray((1, 2, 3, 4), 2, 2) == ((1, 2), (3, 4)))

Test 2:
    #testresult(twodarray((1, 2, 3), 1, 3) == ((1, 2, 3),))

Test 3:
    #testresult(twodarray((1, 2, 3, 4), 4, 1) == ((1,), (2,), (3,), (4,)))

