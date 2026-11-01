#let absentsmallestpositive(a) = {
    let tot = a.sum()
    let ex = a.map(x => (str(x), true)).to-dict()
    let mul = a.len()
    let n = 1
    while true {
        if n * mul > tot and not(str(n) in ex) {
            break
        }
        n += 1
    }
    n
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(absentsmallestpositive((1, 2, 4, 5, 6)) == 7)

Test 2:
    #testresult(absentsmallestpositive((-5, -2, -1, 3)) == 1)

Test 3:
    #testresult(absentsmallestpositive((1, 2, 3)) == 4)

Test 4:
    #testresult(absentsmallestpositive((2, 3, 7, 8)) == 6)

Test 5:
    #testresult(absentsmallestpositive((1, 1, 1, 10)) == 4)

