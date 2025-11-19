#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let stringalike(a) = {
  if calc.rem-euclid(a.len(), 2) == 1 {
    false
  } else {
    let vt = 0
    let mode = 1
    let av = false
    let ret = ()
    for (i, c) in lower(a).codepoints().enumerate() {
      if i * 2 == a.len() {
        mode = -1
      }
      if c.match(regex("[aeiou]")) != none {
        av = true
        vt += mode
      }
    }
    av and (vt == 0)
  }
}

Test 1:
    #testresult(not stringalike("textbook"))

Test 2:
    #testresult(stringalike("book"))

Test 3:
    #testresult(stringalike("AbCdEfGh"))

Test 4:
    #testresult(not stringalike("rhythmmyth"))

Test 5:
    #testresult(not stringalike("UmpireeAudio"))

