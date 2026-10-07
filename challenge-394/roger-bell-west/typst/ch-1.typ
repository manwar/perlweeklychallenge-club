#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let alternatecase(a) = {
  let uppers = a.codepoints().map(c => c == upper(c))
  let ret = 0
  let queue = ()
  queue.push((uppers, 0))
  while queue.len() > 0 {
    let (up, ct) = queue.remove(0)
    let swaps = ()
    for i in range(up.len() - 1) {
      if up.at(i) == up.at(i + 1) {
        if i > 0 {
          swaps.push(i - 1)
        }
        if i < up.len() - 2 {
          swaps.push(i + 1)
        }
      }
    }
    if swaps.len() == 0 {
      ret = ct
      queue = ()
    } else {
      for sw in swaps {
        let uq = up
        (uq.at(sw), uq.at(sw + 1)) = (uq.at(sw + 1), uq.at(sw))
        queue.push((uq, ct + 1))
      }
    }
  }
  ret
}

Test 1:
    #testresult(alternatecase("aAbB") == 0)

Test 2:
    #testresult(alternatecase("AAbb") == 1)

Test 3:
    #testresult(alternatecase("AAAbbb") == 3)

Test 4:
    #testresult(alternatecase("aABb") == 1)

Test 5:
    #testresult(alternatecase("bBBAaa") == 2)

