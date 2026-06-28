#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let reversestring(a) = {
  if a == "" {
    ""
  } else {
    let b = ""
    let aa = a.clusters()
    let l = a.len() - 1
    for i in range(l + 1) {
      b += aa.at(l - i)
    }
    b
  }
}

Test 1:
    #testresult(reversestring("") == "")

Test 2:
    #testresult(reversestring("reverse the given string") == "gnirts nevig eht esrever")

