#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let alphabetindexdigitsum(a, k) = {
  let st = ""
  for c in a.codepoints() {
    st += str(str.to-unicode(c) - 96)
  }
  let v = int(st)
  for _ in range(k) {
    let j = 0
    while v > 0 {
      j += calc.rem-euclid(v, 10)
      v = calc.div-euclid(v, 10)
    }
    v = j
  }
  v
}

Test 1:
    #testresult(alphabetindexdigitsum("abc", 1) == 6)

Test 2:
    #testresult(alphabetindexdigitsum("az", 2) == 9)

Test 3:
    #testresult(alphabetindexdigitsum("cat", 1) == 6)

Test 4:
    #testresult(alphabetindexdigitsum("dog", 2) == 8)

Test 5:
    #testresult(alphabetindexdigitsum("perl", 3) == 6)

