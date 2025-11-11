#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let longestparenthesis(a) = {
  let ml = 0
  for l in range(a.len()) {
    for r in range(l, a.len()) {
      let depth = 0
      let valid = true
      for i in range(l, r + 1) {
        if a.at(i) == "(" {
          depth += 1
        } else {
          depth -= 1
          if depth < 0 {
            valid = false
            break
          }
        }
      }
      if depth != 0 {
        valid = false
      }
      if valid {
        ml = calc.max(ml, r - l + 1)
      }
    }
  }
  ml
}

Test 1:
    #testresult(longestparenthesis("(()())") == 6)

Test 2:
    #testresult(longestparenthesis(")()())") == 4)

Test 3:
    #testresult(longestparenthesis("((()))()(((()") == 8)

Test 4:
    #testresult(longestparenthesis("))))((()(") == 2)

Test 5:
    #testresult(longestparenthesis("()(()") == 2)

