#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let pythagorasmultiplied(n) = {
  let ct = 0
  for c in range(5, n + 1) {
    let csquared = c * c
    for a in range(1, c - 1) {
      let asquared = a * a
      for b in range(a + 1, c) {
        let bsquared = b * b
        let tot = asquared + bsquared
        if tot > csquared {
          break
        }
        if tot == csquared {
          ct += 1
        }
      }
    }
  }
  ct * 2
}

Test 1:
    #testresult(pythagorasmultiplied(20) == 12)

Test 2:
    #testresult(pythagorasmultiplied(7) == 2)

Test 3:
    #testresult(pythagorasmultiplied(1) == 0)

Test 4:
    #testresult(pythagorasmultiplied(15) == 8)

Test 5:
    #testresult(pythagorasmultiplied(30) == 22)

