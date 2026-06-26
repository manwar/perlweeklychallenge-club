#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let armstrongnumber(base, limit) = {
  let out = ()
  for candidate in range(limit) {
    let digits = ()
    if candidate == 0 {
      digits.push(0)
    } else {
      let c = candidate
      while c > 0 {
        digits.push(calc.rem-euclid(c, base))
        c = calc.div-euclid(c, base)
      }
    }
    let dl = digits.len()
    let test = digits.map(x => calc.pow(x, dl)).sum()
    if test == candidate {
      out.push(candidate)
    }
  }
  out
}

Test 1:
    #testresult(armstrongnumber(10, 1000) == (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407))

Test 2:
    #testresult(armstrongnumber(7, 1000) == (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250))

Test 3:
    #testresult(armstrongnumber(16, 1000) == (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645))

