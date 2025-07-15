#let cleardigits(a) = {
  let out = ()
  for c in a {
    if c >= "0" and c <= "9" {
      let _ = out.pop()
    } else {
      out.push(c)
    }
  }
  if out.len() == 0 {
    ""
  } else {
    out.join("")
  }
}

#let testresult(result) = {
  if result {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(cleardigits("cab12") == "c")

Test 2:
    #testresult(cleardigits("xy99") == "")

Test 3:
    #testresult(cleardigits("pa1erl") == "perl")

