#let cw(n, vw) = {
  let res = ()
  for (val, word) in vw {
    if (n >= val) {
      let andflag = false
      if (n >= 100) {
        andflag = true
        for w in cw(calc.div-euclid(n, val), vw) {
          res.push(w)
        }
      }
      res.push(word)
      let p = calc.rem-euclid(n, val)
      if p > 0 {
        if andflag {
          res.push("and")
        }
        for w in cw(p, vw) {
          res.push(w)
        }
      }
    break
    }
  }
  res
}

#let towords(a) = {
  if (a == 0) {
    return "zero"
  }
  let components = ()
  let b = a
  if a < 0 {
    b = -a
    components.push("minus")
  }
  let vw = (
    (1000000000, "milliard"),
    (1000000, "million"),
    (1000, "thousand"),
    (100, "hundred"),
    (90, "ninety"),
    (80, "eighty"),
    (70, "seventy"),
    (60, "sixty"),
    (50, "fifty"),
    (40, "forty"),
    (30, "thirty"),
    (20, "twenty"),
    (19, "nineteen"),
    (18, "eighteen"),
    (17, "seventeen"),
    (16, "sixteen"),
    (15, "fifteen"),
    (14, "fourteen"),
    (13, "thirteen"),
    (12, "twelve"),
    (11, "eleven"),
    (10, "ten"),
    (9, "nine"),
    (8, "eight"),
    (7, "seven"),
    (6, "six"),
    (5, "five"),
    (4, "four"),
    (3, "three"),
    (2, "two"),
    (1, "one"),
  )
  for w in cw(b, vw) {
    components.push(w)
  }
  components.join(" ")
}

#let spellboundsorting(a) = {
  a.sorted(key: x => towords(x))
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(spellboundsorting((6, 7, 8, 9, 10)) == (8, 9, 7, 6, 10))

Test 2:
    #testresult(spellboundsorting((-3, 0, 1000, 99)) == (-3, 99, 1000, 0))

Test 3:
    #testresult(spellboundsorting((1, 2, 3, 4, 5)) == (5, 4, 1, 3, 2))

Test 4:
    #testresult(spellboundsorting((0, -1, -2, -3, -4)) == (-4, -1, -3, -2, 0))

Test 5:
    #testresult(spellboundsorting((100, 101, 102)) == (100, 101, 102))

