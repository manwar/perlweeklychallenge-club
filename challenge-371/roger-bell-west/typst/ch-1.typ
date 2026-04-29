#let missingletter(a) = {
  let c = a.codepoints().filter(x => x != " ").map(x => x.to-unicode())
  let d = ()
  for i in c.windows(2) {
    if i.at(0) == 63 or i.at(1) == 63 {
      d.push(0)
    } else {
      d.push(i.at(1) - i.at(0))
    }
  }
  let ch = 32
  for (n, delta) in d.enumerate() {
    if delta == 0 {
      if n < 2 {
        ch = c.at(n + 2) - d.at(n + 2)
      } else {
        ch = c.at(n) + d.at(n - 2)
      }
      break
    }
  }
  str.from-unicode(ch)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(missingletter("a c ? g i") == "e")

Test 2:
    #testresult(missingletter("a d ? j m") == "g")

Test 3:
    #testresult(missingletter("a e ? m q") == "i")

Test 4:
    #testresult(missingletter("a c f ? k") == "h")

Test 5:
    #testresult(missingletter("b e g ? l") == "j")

