#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let validtimes(a) = {
  let combinator = ()
  let r = regex("[0-9]")
  for (i, c) in a.codepoints().enumerate() {
    if r in c {
      combinator.push((int(c),))
    } else {
      if i == 0 {
        combinator.push(range(2 + 1))
      } else if i == 1 or i == 4 {
        combinator.push(range(9 + 1))
      } else if i == 3 {
        combinator.push(range(5 + 1))
      }
    }
  }
  if combinator.len() != 4 {
    0
  } else {
    let minutes = combinator.at(2).len() * combinator.at(3).len()
    let ct = 0
    for ax in combinator.at(0) {
      for bx in combinator.at(1) {
        if ax * 10 + bx <= 23 {
          ct += 1
        }
      }
    }
    ct * minutes
  }
}

Test 1:
    #testresult(validtimes("?2:34") == 3)

Test 2:
    #testresult(validtimes("?4:?0") == 12)

Test 3:
    #testresult(validtimes("??:??") == 1440)

Test 4:
    #testresult(validtimes("?3:45") == 3)

Test 5:
    #testresult(validtimes("2?:15") == 4)

