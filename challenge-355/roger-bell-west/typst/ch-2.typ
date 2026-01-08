#let mountainarray(a) = {
  let state = 0
  let valid = true
  for b in a.windows(2) {
    if b.at(1) > b.at(0) {
      if state == 0 or state == 1 {
        state = 1
      } else {
        valid = false
      }
    } else if b.at(1) < b.at(0) {
      if state == 1 or state == 2 {
        state = 2
      } else {
        valid = false
      }
    } else {
      valid = false
    }
  }
  valid and (state == 2)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(not mountainarray((1, 2, 3, 4, 5)))

Test 2:
    #testresult(mountainarray((0, 2, 4, 6, 4, 2, 0)))

Test 3:
    #testresult(not mountainarray((5, 4, 3, 2, 1)))

Test 4:
    #testresult(not mountainarray((1, 3, 5, 5, 4, 2)))

Test 5:
    #testresult(mountainarray((1, 3, 2)))

