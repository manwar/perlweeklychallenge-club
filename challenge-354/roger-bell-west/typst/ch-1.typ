#let minabsdiff(a) = {
  let b = a.sorted()
  let out = ()
  let mindiff = b.last() - b.first() + 1
  for c in b.windows(2) {
    let d = c.at(1) - c.at(0)
    if d < mindiff {
      out = ()
      mindiff = d
    }
    if d == mindiff {
      out.push(c)
    }
  }
  out
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(minabsdiff((4, 2, 1, 3)) == ((1, 2), (2, 3), (3, 4)))

Test 2:
    #testresult(minabsdiff((10, 100, 20, 30)) == ((10, 20), (20, 30)))

Test 3:
    #testresult(minabsdiff((-5, -2, 0, 3)) == ((-2, 0),))

Test 4:
    #testresult(minabsdiff((8, 1, 15, 3)) == ((1, 3),))

Test 5:
    #testresult(minabsdiff((12, 5, 9, 1, 15)) == ((9, 12), (12, 15)))

