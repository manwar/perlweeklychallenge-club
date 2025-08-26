#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let finalscore(a) = {
  let p = ()
  for n in a {
    if n == "C" {
      let _ = p.pop()
    } else if n == "D" {
      p.push(p.at(-1) * 2)
    } else if n == "+" {
      p.push(p.at(-2) + p.at(-1))
    } else {
      p.push(int(n))
    }
  }
  p.sum()
}

Test 1:
    #testresult(finalscore(("5", "2", "C", "D", "+")) == 30)

Test 2:
    #testresult(finalscore(("5", "-2", "4", "C", "D", "9", "+", "+")) == 27)

Test 3:
    #testresult(finalscore(("7", "D", "D", "C", "+", "3")) == 45)

Test 4:
    #testresult(finalscore(("-5", "-10", "+", "D", "C", "+")) == -55)

Test 5:
    #testresult(finalscore(("3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+")) == 128)

