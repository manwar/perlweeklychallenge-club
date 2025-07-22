#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let buddystrings(a, b) = {
  let ac = a.split("")
  let _ = ac.remove(0)
  let _ = ac.pop()
  let bc = b.split("")
  let _ = bc.remove(0)
  let _ = bc.pop()
  let v = false
  for i in range(0, ac.len() - 1) {
    for j in range(i + 1, ac.len()) {
      let acx = ac
      acx.at(i) = ac.at(j)
      acx.at(j) = ac.at(i)
      if acx == bc {
        v = true
        break
      }
    }
    if v {
      break
    }
  }
  v
}

Test 1:
    #testresult(buddystrings("fuck", "fcuk"))

Test 2:
    #testresult(not buddystrings("love", "love"))

Test 3:
    #testresult(buddystrings("fodo", "food"))

Test 4:
    #testresult(buddystrings("feed", "feed"))

