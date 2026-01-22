#let a2n(a) = {
  let t = 0
  for d in a {
    t *= 10
    t += d
  }
  t
}

#let kaprekarconstant(a) = {
  let ct = 0
  let b = a
  while b != 6174 {
    if b == 0 {
      ct = -1
      break
    }
    let digits = ()
    for _ in range(4) {
      digits.push(calc.rem-euclid(b, 10))
      b = calc.quo(b, 10)
    }
    digits = digits.sorted()
    let stigid = digits.rev()
    b = a2n(stigid) - a2n(digits)
    ct += 1
  }
  ct
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(kaprekarconstant(3524) == 3)

Test 2:
    #testresult(kaprekarconstant(6174) == 0)

Test 3:
    #testresult(kaprekarconstant(9998) == 5)

Test 4:
    #testresult(kaprekarconstant(1001) == 4)

Test 5:
    #testresult(kaprekarconstant(9000) == 4)

Test 6:
    #testresult(kaprekarconstant(1111) == -1)

