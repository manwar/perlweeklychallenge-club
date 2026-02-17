#let zeckendorfrepresentation(a) = {
  let fib = (0, 1)
  while fib.at(-1) <= a {
    fib.push(fib.at(-1) + fib.at(-2))
  }
  let _ = fib.pop()
  let res = ()
  let aw = a
  while aw > 0 {
    res.push(fib.at(-1))
    aw -= fib.at(-1)
    _ = fib.pop()
    _ = fib.pop()
    while fib.at(-1) > aw {
    _ = fib.pop()
    }
  }
  res
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(zeckendorfrepresentation(4) == (3, 1))

Test 2:
    #testresult(zeckendorfrepresentation(12) == (8, 3, 1))

Test 3:
    #testresult(zeckendorfrepresentation(20) == (13, 5, 2))

Test 4:
    #testresult(zeckendorfrepresentation(96) == (89, 5, 2))

Test 5:
    #testresult(zeckendorfrepresentation(100) == (89, 8, 3))

