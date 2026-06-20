#let secondlargestdigit(a) = {
  let p = a.clusters().filter(x => x >= "0" and x <= "9").map(x => (x, true)).to-dict()
  let k = p.keys().sorted(by: (i, j) => i >= j)
  if k.len() > 1 {
    int(k.at(1))
  } else {
    -1
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
    #testresult(secondlargestdigit("aaaaa77777") == -1)

Test 2:
    #testresult(secondlargestdigit("abcde") == -1)

Test 3:
    #testresult(secondlargestdigit("9zero8eight7seven9") == 8)

Test 4:
    #testresult(secondlargestdigit("xyz9876543210") == 8)

Test 5:
    #testresult(secondlargestdigit("4abc4def2ghi8jkl2") == 4)

