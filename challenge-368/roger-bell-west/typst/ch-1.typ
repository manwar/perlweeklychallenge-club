#let makeitbigger(st, ch) = {
  let cc = st.codepoints()
  let nn = ()
  for i in range(cc.len()) {
    if st.at(i) == ch {
      let o = ""
      if i > 0 {
        o += st.slice(0, count: i)
      }
      if i < cc.len() - 1 {
        o += st.slice(i + 1)
      }
      nn.push(int(o))
    }
  }
  str(calc.max(..nn))
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(makeitbigger("15456", "5") == "1546")

Test 2:
    #testresult(makeitbigger("7332", "3") == "732")

Test 3:
    #testresult(makeitbigger("2231", "2") == "231")

Test 4:
    #testresult(makeitbigger("543251", "5") == "54321")

Test 5:
    #testresult(makeitbigger("1921", "1") == "921")

