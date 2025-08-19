#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let findwinner(a) = {
  let outcome = "Null"
  let board = (
    ( 0, 0, 0 ), 
    ( 0, 0, 0 ), 
    ( 0, 0, 0 )
  )
  let player = 1
  for play in a {
    board.at(play.at(0)).at(play.at(1)) = player
    player = 3 - player
  }
  for pattern in (
    (0, 0, 1, 0),
    (0, 1, 1, 0),
    (0, 2, 1, 0),
    (0, 0, 0, 1),
    (1, 0, 0, 1),
    (2, 0, 0, 1),
    (0, 0, 1, 1),
    (0, 2, 1, -1),
  ) {
    let cellvals = (:)
    for i in range(3) {
      let x = pattern.at(0) + i * pattern.at(2)
      let y = pattern.at(1) + i * pattern.at(3)
      cellvals.insert(str(board.at(y).at(x)), true)
    }
    if cellvals.len() == 1 {
      let winner = cellvals.keys().at(0)
      if winner == "1" {
        outcome = "A"
        break
      } else if winner == "2" {
        outcome = "B"
        break
      }
    }
  }
  if outcome == "Null" {
    if a.len() == 9 {
      outcome = "Draw"
    } else {
      outcome = "Pending"
    }
  }
  outcome
}

Test 1:
    #testresult(findwinner(((0, 0), (2, 0), (1, 1), (2, 1), (2, 2))) == "A")

Test 2:
    #testresult(findwinner(((0, 0), (1, 1), (0, 1), (0, 2), (1, 0), (2, 0))) == "B")

Test 3:
    #testresult(findwinner(((0, 0), (1, 1), (2, 0), (1, 0), (1, 2), (2, 1), (0, 1), (0, 2), (2, 2))) == "Draw")

Test 4:
    #testresult(findwinner(((0, 0), (1, 1))) == "Pending")

Test 5:
    #testresult(findwinner(((1, 1), (0, 0), (2, 2), (0, 1), (1, 0), (0, 2))) == "B")

