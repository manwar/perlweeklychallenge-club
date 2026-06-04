#let cs2xy(a) = {
  let c = a.clusters()
  let x = c.at(0).to-unicode() - "a".to-unicode()
  let y = c.at(1).to-unicode() - "1".to-unicode()
  (x, y)
}

#let checkcolor(a) = {
  let xy = cs2xy(a)
  calc.rem-euclid(xy.at(0) + xy.at(1), 2) == 1
}

#let chessboardsquares(a, b) = {
  checkcolor(a) == checkcolor(b)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(chessboardsquares("a7", "f4"))

Test 2:
    #testresult(not chessboardsquares("c1", "e8"))

Test 3:
    #testresult(not chessboardsquares("b5", "h2"))

Test 4:
    #testresult(chessboardsquares("f3", "h1"))

Test 5:
    #testresult(not chessboardsquares("a1", "g8"))

