#let consecutiveone(a) = {
  let h = ("0": 0)
  let latch = 0
  let latched = false
  for (i, n) in a.enumerate() {
    if n == 1 and not latched {
      latched = true
      latch = i
    }
    if n == 0 and latched {
      latched = false
      h.insert(str(latch), i - latch)
    }
  }
  if latched {
    h.insert(str(latch), a.len() - latch)
  }
  calc.max(.. h.values())
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(consecutiveone((0, 1, 1, 0, 1, 1, 1)) == 3)

Test 2:
    #testresult(consecutiveone((0, 0, 0, 0)) == 0)

Test 3:
    #testresult(consecutiveone((1, 0, 1, 0, 1, 1)) == 2)

