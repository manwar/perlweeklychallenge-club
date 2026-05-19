#let largestsubstring(a) = {
  let cc = a.clusters()
  let found = false
  let off = 0
  for offset in range(1, cc.len()).rev() {
    if not found {
      for x in range(cc.len() - offset) {
        if not found {
          if cc.at(x) == cc.at(x + offset) {
            found = true
            off = offset
            break
          }
        }
      }
      if found {
        break
      }
    }
  }
  off - 1
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(largestsubstring("aaaaa") == 3)

Test 2:
    #testresult(largestsubstring("abcdeba") == 5)

Test 3:
    #testresult(largestsubstring("abbc") == 0)

Test 4:
    #testresult(largestsubstring("abcaacbc") == 4)

Test 5:
    #testresult(largestsubstring("laptop") == 2)

