#let goalparser(a) = {
  let out = ""
  let s = 0
  while s < a.len() {
    if a.slice(s).starts-with("G") {
      s += 1
      out += "G"
    } else if a.slice(s).starts-with("()") {
      s += 2
      out += "o"
    } else if a.slice(s).starts-with("(al)") {
      s += 4
      out += "al"
    } else {
      out = ""
      break
    }
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
    #testresult(goalparser("G()(al)") == "Goal")

Test 2:
    #testresult(goalparser("G()()()()(al)") == "Gooooal")

Test 3:
    #testresult(goalparser("(al)G(al)()()") == "alGaloo")

Test 4:
    #testresult(goalparser("()G()G") == "oGoG")

Test 5:
    #testresult(goalparser("(al)(al)G()()") == "alalGoo")

