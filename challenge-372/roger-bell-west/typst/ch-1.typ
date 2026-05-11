#let rearrangespaces(a) = {
  let words = ()
  let spaces = 0
  let ww = ""
  for c in a.clusters() {
    if c == " " {
      spaces += 1
      if ww.len() > 0 {
        words.push(ww)
        ww = ""
      }
    } else {
      ww += c
    }
  }
  if ww.len() > 0 {
    words.push(ww)
  }
  let spdiv = 0
  let remainder = spaces
  let divs = words.len() - 1
  if divs > 0 {
    spdiv = calc.div-euclid(spaces, divs)
    remainder = calc.rem-euclid(spaces, divs)
  }
  let out = words.join(" " * spdiv)
  if remainder > 0 {
    out += " " * remainder
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
    #testresult(rearrangespaces("  challenge  ") == "challenge    ")

Test 2:
    #testresult(rearrangespaces("coding  is  fun") == "coding  is  fun")

Test 3:
    #testresult(rearrangespaces("a b c  d") == "a b c d ")

Test 4:
    #testresult(rearrangespaces("  team      pwc  ") == "team          pwc")

Test 5:
    #testresult(rearrangespaces("   the  weekly  challenge  ") == "the    weekly    challenge ")

