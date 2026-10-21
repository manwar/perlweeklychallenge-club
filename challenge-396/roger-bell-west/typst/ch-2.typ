#let trionicarray(a) = {
  let ret = true
  let state = 0
  let prev = a.at(0)
  for i in range(1, a.len()) {
    let n = a.at(i)
    let dir = 0
    if n > prev {
       dir = 1;
    } else if n < prev {
       dir = -1;
    }
    if dir == 0 {
      ret = false
      break
    }
    if state == 0 {
      if dir == 1 {
        state = 1
      } else {
        ret = false
        break
      }
    } else if state == 1 {
      if dir == -1 {
        state = 2
      }
    } else if state == 2 {
      if dir == 1 {
        state = 3
      }
    } else if state == 3 {
      if dir == -1 {
        ret = false
        break
      }
    } else {
      ret = false
      break
    }
    prev = n
  }
  if ret {
    ret = state == 3
  }
  ret
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(trionicarray((1, 3, 5, 4, 2, 6, 8)))

Test 2:
    #testresult(not trionicarray((1, 4, 4, 2, 1, 3, 5)))

Test 3:
    #testresult(trionicarray((2, 10, 3, 1, 9)))

Test 4:
    #testresult(not trionicarray((1, 2, 3, 4, 3, 2, 1)))

Test 5:
    #testresult(not trionicarray((1, 3, 2, 4, 1, 5, 2)))

