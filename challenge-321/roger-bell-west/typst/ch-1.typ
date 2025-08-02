#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let distinctaverage(a0) = {
  let a = a0.sorted()
  let offset = a.len() - 1
  let res = ().to-dict()
  for i in range(int(a.len() / 2)) {
    res.insert(str(a.at(i) + a.at(offset - i)), true)
  }
  res.len()
}

Test 1:
    #testresult(distinctaverage((1, 2, 4, 3, 5, 6)) == 1)

Test 2:
    #testresult(distinctaverage((0, 2, 4, 8, 3, 5)) == 2)

Test 3:
    #testresult(distinctaverage((7, 3, 1, 0, 5, 9)) == 2)

