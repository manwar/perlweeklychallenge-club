#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let counterify(a) = {
  let c = (:)
  for nn in a {
    let n = str(nn)
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let meetingpoint(a) = {
  let c = counterify(a.codepoints())
  c.at("U", default: 0) == c.at("D", default: 0) and c.at("L", default: 0) == c.at("R", default: 0)
}

Test 1:
    #testresult(not meetingpoint("ULD"))

Test 2:
    #testresult(meetingpoint("ULDR"))

Test 3:
    #testresult(not meetingpoint("UUURRRDDD"))

Test 4:
    #testresult(meetingpoint("UURRRDDLLL"))

Test 5:
    #testresult(not meetingpoint("RRUULLDDRRUU"))

