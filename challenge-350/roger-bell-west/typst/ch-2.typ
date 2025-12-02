// warning DO NOT RUN the commented-out tests

#let counterify(a) = {
  let c = (:)
  for nn in a {
    let n = str(nn)
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let countdigits(a) = {
  counterify(str(a))
}

#let shufflepairs(low, high, pairs) = {
  let total = 0
  for candidate in range(low, high + 1) {
    let candidatec = countdigits(candidate)
    let cnt = 0
    for mul in range(2, 10) {
      let test = candidate * mul
      let testc = countdigits(test)
      if testc == candidatec {
        cnt += 1
        if cnt >= pairs {
          break
        }
      }
    }
    if cnt >= pairs {
      total += 1
    }
  }
  total
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(shufflepairs(1, 1000, 1) == 0)

Test 2:
    #testresult(shufflepairs(1500, 2500, 1) == 3)

Test 3:
//    #testresult(shufflepairs(1000000, 1500000, 5) == 2)

Test 4:
//    #testresult(shufflepairs(13427000, 14100000, 2) == 11)

Test 5:
    #testresult(shufflepairs(1000, 5000, 1) == 7)
