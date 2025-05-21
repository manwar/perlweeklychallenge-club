#let formatstring(a, n) = {
  let p = a.clusters().filter(x => x != "-")
  let r = calc.rem(p.len(), n)
  if r == 0 {
    r += n
  }
  let o = ""
  for (i, c) in p.enumerate() {
    if r == i {
      o += "-"
      r += n
    }
    o += c
  }
  o
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(formatstring("ABC-D-E-F", 3) == "ABC-DEF")

Test 2:
    #testresult(formatstring("A-BC-D-E", 2) == "A-BC-DE")

Test 3:
    #testresult(formatstring("-A-B-CD-E", 4) == "A-BCDE")

