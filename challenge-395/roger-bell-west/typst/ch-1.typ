#let parsecomplex(a) = {
  let re = regex(`^\(?([-0-9]+)\)?\+\(?([-0-9]+)\)?i$`.text)
  let md = a.match(re)
  if md != none {
    (int(md.captures.at(0)), int(md.captures.at(1)))
  } else {
    (0, 0)
  }
}

#let complexnumber(aa, bb) = {
  let (a, b) = parsecomplex(aa)
  let (c, d) = parsecomplex(bb)
  let ca = a * c - b * d
  let cas = if ca >= 0 { str(ca) } else { "-" + str(-ca) }
  let cb = a * d + b * c
  let cbs = if cb >= 0 { str(cb) } else { "-" + str(-cb) }
  if cb >= 0 {
    cas + "+" + cbs + "i"
  } else {
    cas + "+(" + cbs + ")i"
  }
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(complexnumber("1+1i", "1+1i") == "0+2i")

Test 2:
    #testresult(complexnumber("1+(-1)i", "1+(-1)i") == "0+(-2)i")

Test 3:
    #testresult(complexnumber("0+3i", "0+4i") == "-12+0i")

Test 4:
    #testresult(complexnumber("3+4i", "3+(-4)i") == "25+0i")

Test 5:
    #testresult(complexnumber("50+-20i", "-10+30i") == "100+1700i")

