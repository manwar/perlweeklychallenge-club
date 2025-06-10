#let finalprice(a) = {
  let out = ()
  for (i, n) in a.enumerate() {
    let discount = 0
    for mi in range(i + 1, a.len()) {
      if a.at(mi) <= n {
        discount = a.at(mi)
        break
      }
    }
    out.push(n - discount)
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
    #testresult(finalprice((8, 4, 6, 2, 3)) == (4, 2, 4, 2, 3))

Test 2:
    #testresult(finalprice((1, 2, 3, 4, 5)) == (1, 2, 3, 4, 5))

Test 3:
    #testresult(finalprice((7, 1, 1, 5)) == (6, 0, 1, 5))

