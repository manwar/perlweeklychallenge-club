#let titlecapital(a) = {
  let out = ()
  for w in a.split(" ") {
    let p = lower(w)
    if p.len() > 2 {
      let c = p.codepoints();
      c.at(0) = upper(c.at(0))
      p = c.join("")
    }
    out.push(p)
  }
  out.join(" ")
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(titlecapital("PERL IS gREAT") == "Perl is Great")

Test 2:
    #testresult(titlecapital("THE weekly challenge") == "The Weekly Challenge")

Test 3:
    #testresult(titlecapital("YoU ARE A stAR") == "You Are a Star")

