#let decompressedlist(a) = {
  let out = ()
  for (n, v) in a.chunks(2) {
    for _ in range(n) {
      out.push(v)
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
    #testresult(decompressedlist((1, 3, 2, 4)) == (3, 4, 4))

Test 2:
    #testresult(decompressedlist((1, 1, 2, 2)) == (1, 2, 2))

Test 3:
    #testresult(decompressedlist((3, 1, 3, 2)) == (1, 1, 1, 2, 2, 2))

