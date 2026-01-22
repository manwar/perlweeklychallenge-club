#let uniquefractiongenerator(a) = {
  let den = 1
  for dn in range(2, a + 1) {
    den *= dn
  }
  let f = (:)
  for d in range(1, a + 1) {
    let nd = calc.quo(den, d)
    for n in range(1, a + 1) {
      f.insert(str(n * nd), true)
    }
  }
  let ff = f.keys().map(x => int(x)).sorted()
  let out = ()
  for n in ff {
    let g = calc.gcd(n, den)
    let nn = calc.quo(n, g)
    let nd = calc.quo(den, g)
    out.push(str(nn) + "/" + str(nd))
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
    #testresult(uniquefractiongenerator(3) == ("1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"))

Test 2:
    #testresult(uniquefractiongenerator(4) == ("1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1"))

Test 3:
    #testresult(uniquefractiongenerator(1) == ("1/1",))

Test 4:
    #testresult(uniquefractiongenerator(6) == ("1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1"))

Test 5:
    #testresult(uniquefractiongenerator(5) == ("1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1"))

