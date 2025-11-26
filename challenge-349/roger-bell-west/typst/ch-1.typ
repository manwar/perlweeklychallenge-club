#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let powerstring(a) = {
  let mx = 0
  let prev = "A"
  let cur = 0
  for c in a.codepoints() {
    if cur > 0 and c == prev {
      cur += 1
    } else {
      cur = 1
      prev = c
    }
    mx = calc.max(mx, cur)
  }
  mx
}

Test 1:
    #testresult(powerstring("textbook") == 2)

Test 2:
    #testresult(powerstring("aaaaa") == 5)

Test 3:
    #testresult(powerstring("hoorayyy") == 3)

Test 4:
    #testresult(powerstring("x") == 1)

Test 5:
    #testresult(powerstring("aabcccddeeffffghijjk") == 4)

