#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let replacequestionmark(a) = {
  let template = a.clusters()
  let q = template.filter(x => x == "?").len()
  if q == 0 {
    (a,)
  } else {
    let out = ()
    for n in range(1.bit-lshift(q)) {
      let qm = ()
      let nn = n
      while nn > 0 {
        qm.push(str(calc.rem-euclid(nn, 2)))
        nn = calc.div-euclid(nn, 2)
      }
      while qm.len() < q {
        qm.push("0")
      }
      let entry = ""
      for tc in template {
        if tc == "?" {
          entry += qm.pop()
        } else {
          entry += tc
        }
      }
      out.push(entry)
    }
    out
  }
}

Test 1:
    #testresult(replacequestionmark("01??0") == ("01000", "01010", "01100", "01110"))

Test 2:
    #testresult(replacequestionmark("101") == ("101",))

Test 3:
    #testresult(replacequestionmark("???") == ("000", "001", "010", "011", "100", "101", "110", "111"))

Test 4:
    #testresult(replacequestionmark("1?10") == ("1010", "1110"))

Test 5:
    #testresult(replacequestionmark("1?1?0") == ("10100", "10110", "11100", "11110"))

