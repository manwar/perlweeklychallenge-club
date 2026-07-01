#let counterify(a) = {
  let c = (:)
  for nn in a {
    let n = str(nn)
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let sumoffrequencies(a) = {
  let vw = 0
  let cn = 0
  let cc = counterify(a.clusters())
  let cv = cc.values().sorted().rev()
  for n in cv {
    for c in cc.filter(ni => ni == n).keys() {
      if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" {
        if vw == 0 {
          vw = n
        }
      } else {
        if cn == 0 {
          cn = n
        }
      }
    }
    if vw > 0 and cn > 0 {
      break
    }
  }
  vw + cn
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(sumoffrequencies("banana") == 5)

Test 2:
    #testresult(sumoffrequencies("teestett") == 7)

Test 3:
    #testresult(sumoffrequencies("aeiouuaa") == 3)

Test 4:
    #testresult(sumoffrequencies("rhythm") == 2)

Test 5:
    #testresult(sumoffrequencies("x") == 1)

