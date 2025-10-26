#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let u2a(a) = {
  let p = a
  if p > 0 {
    let out = ()
    while p > 0 {
      out.push(calc.rem-euclid(p, 10))
      p = calc.div-euclid(p, 10)
    }
    out.rev()
  } else {
    (0)
  }
}

#let a2u(a) = {
  let acc = 0
  for d in a {
    acc *= 10
    acc += d
  }
  acc
}

#let arrayformcompute(a, b) = {
  u2a(a2u(a) + b)
}

Test 1:
    #testresult(arrayformcompute((1, 2, 3, 4), 12) == (1, 2, 4, 6))

Test 2:
    #testresult(arrayformcompute((2, 7, 4), 181) == (4, 5, 5))

Test 3:
    #testresult(arrayformcompute((9, 9, 9), 1) == (1, 0, 0, 0))

Test 4:
    #testresult(arrayformcompute((1, 0, 0, 0, 0), 9999) == (1, 9, 9, 9, 9))

Test 5:
    #testresult(arrayformcompute((0, ), 1000) == (1, 0, 0, 0))

