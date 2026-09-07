#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let dyckwords(order) = {
  let out = ()
  let queue = ()
  queue.push("")
  while queue.len() > 0 {
    let st = queue.remove(0)
    let dcount = st.clusters().filter(c => c == "D").len()
    if st.len() == order * 2 {
      if dcount == order {
        out.push(st)
      }
    } else {
      if dcount * 2 < st.len() {
        queue.push(st + "D")
      }
      queue.push(st + "U")
    }
  }
  out
}

Test 1:
    #testresult(dyckwords(1) == ("UD",))

Test 2:
    #testresult(dyckwords(2) == ("UDUD", "UUDD"))

Test 3:
    #testresult(dyckwords(3) == ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"))

Test 4:
    #testresult(dyckwords(0) == ("",))

Test 5:
    #testresult(dyckwords(4) == ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"))

