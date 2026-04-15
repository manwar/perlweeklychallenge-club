#let groupdivision(a0, sz, pad) = {
  let a = a0
  while calc.rem-euclid(a.len(), sz) != 0 {
    a += pad
  }
  let out = ()
  let i = 0
  while i < a.len() {
    out.push(a.slice(i, count: sz))
    i += sz
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
    #testresult(groupdivision("RakuPerl", 4, "*") == ("Raku", "Perl"))

Test 2:
    #testresult(groupdivision("Python", 5, "0") == ("Pytho", "n0000"))

Test 3:
    #testresult(groupdivision("12345", 3, "x") == ("123", "45x"))

Test 4:
    #testresult(groupdivision("HelloWorld", 3, "_") == ("Hel", "loW", "orl", "d__"))

Test 5:
    #testresult(groupdivision("AI", 5, "!") == ("AI!!!",))

