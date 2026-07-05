#let reversedegree(a) = {
  let t = 0
  let z0 = "z".to-unicode() + 1
  for (i, c) in a.clusters().enumerate() {
    t += (z0 - c.to-unicode()) * (1 + i)
  }
  t
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(reversedegree("z") == 1)

Test 2:
    #testresult(reversedegree("a") == 26)

Test 3:
    #testresult(reversedegree("bbc") == 147)

Test 4:
    #testresult(reversedegree("racecar") == 560)

Test 5:
    #testresult(reversedegree("zyx") == 14)

