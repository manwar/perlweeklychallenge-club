#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let peakpositions(a) = {
  let out = ()
  for (i, x) in a.enumerate() {
    if (i == 0 or x > a.at(i - 1)) and (i == a.len() - 1 or x > a.at(i + 1)) {
      out.push(i)
    }
  }
  out
}

Test 1:
    #testresult(peakpositions((1, 3, 2)) == (1,))

Test 2:
    #testresult(peakpositions((2, 4, 6, 5, 3)) == (2,))

Test 3:
    #testresult(peakpositions((1, 2, 3, 2, 4, 1)) == (2, 4))

Test 4:
    #testresult(peakpositions((5, 3, 1)) == (0,))

Test 5:
    #testresult(peakpositions((1, 5, 1, 5, 1, 5, 1)) == (1, 3, 5))

