#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let championteam(a) = {
  let maxw = 0
  let teamw = ()
  for (i, w) in a.enumerate() {
    let wins = w.sum()
    if wins > maxw {
      teamw = ()
      maxw = wins
    }
    if wins == maxw {
      teamw.push(i)
    }
  }
  if teamw.len() == 1 {
    teamw.at(0)
  } else {
    let bestt = teamw.at(0)
    for rt in teamw {
      if a.at(rt).at(bestt) == 1 {
        bestt = rt
      }
    }
    bestt
  }
}

Test 1:
    #testresult(championteam(((0, 1, 1), (0, 0, 1), (0, 0, 0))) == 0)

Test 2:
    #testresult(championteam(((0, 1, 0, 0), (0, 0, 0, 0), (1, 1, 0, 0), (1, 1, 1, 0))) == 3)

Test 3:
    #testresult(championteam(((0, 1, 0, 1), (0, 0, 1, 1), (1, 0, 0, 0), (0, 0, 1, 0))) == 0)

Test 4:
    #testresult(championteam(((0, 1, 1), (0, 0, 0), (0, 1, 0))) == 0)

Test 5:
    #testresult(championteam(((0, 0, 0, 0, 0), (1, 0, 0, 0, 0), (1, 1, 0, 1, 1), (1, 1, 0, 0, 0), (1, 1, 0, 1, 0))) == 2)

