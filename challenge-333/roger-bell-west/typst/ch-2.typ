#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let duplicatezeros(a) = {
  let b = ()
  for n in a {
    b.push(n)
    if a.len() == b.len() {
      break
    }
    if n == 0 {
      b.push(0)
      if a.len() == b.len() {
        break
      }
    }
  }
  b
}

Test 1:
    #testresult(duplicatezeros((1, 0, 2, 3, 0, 4, 5, 0)) == (1, 0, 0, 2, 3, 0, 0, 4))

Test 2:
    #testresult(duplicatezeros((1, 2, 3)) == (1, 2, 3))

Test 3:
    #testresult(duplicatezeros((1, 2, 3, 0)) == (1, 2, 3, 0))

Test 4:
    #testresult(duplicatezeros((0, 0, 1, 2)) == (0, 0, 0, 0))

Test 5:
    #testresult(duplicatezeros((1, 2, 0, 3, 4)) == (1, 2, 0, 0, 3))

