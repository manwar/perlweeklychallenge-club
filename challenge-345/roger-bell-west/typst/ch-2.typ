#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let lastvisitor(a) = {
  let seen = ()
  let ans = ()
  let minusones = 0
  for n in a {
    if n == -1 {
      minusones += 1
      if minusones <= seen.len() {
        ans.push(seen.at(minusones - 1))
      } else {
        ans.push(-1)
      }
    } else {
      seen.insert(0, n)
      minusones = 0
    }
  }
  ans
}

Test 1:
    #testresult(lastvisitor((5, -1, -1)) == (5, -1))

Test 2:
    #testresult(lastvisitor((3, 7, -1, -1, -1)) == (7, 3, -1))

Test 3:
    #testresult(lastvisitor((2, -1, 4, -1, -1)) == (2, 4, 2))

Test 4:
    #testresult(lastvisitor((10, 20, -1, 30, -1, -1)) == (20, 30, 20))

Test 5:
    #testresult(lastvisitor((-1, -1, 5, -1)) == (-1, -1, 5))

