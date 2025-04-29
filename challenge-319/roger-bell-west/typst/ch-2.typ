#let arr2set(a) = {
  a.map(x => (str(x), true)).to-dict()
}

#let minimumcommon(a, b) = {
  let aa = arr2set(a)
  let bb = arr2set(b)
  let cc = aa.keys().filter(x => x in bb).map(x => int(x))
  if cc.len() == 0 {
    -1
  } else {
    calc.min(.. cc)
  }
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(minimumcommon((1, 2, 3, 4), (3, 4, 5, 6)) == 3)

Test 2:
    #testresult(minimumcommon((1, 2, 3), (2, 4)) == 2)

Test 3:
    #testresult(minimumcommon((1, 2, 3, 4), (5, 6, 7, 8)) == -1)

