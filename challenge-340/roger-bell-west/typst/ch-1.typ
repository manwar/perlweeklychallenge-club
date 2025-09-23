#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let duplicateremovals(a) = {
  let b = ()
  for c in a {
    if b.len() == 0 or c != b.at(-1) {
      b.push(c)
    } else {
      let _ = b.pop()
    }
  }
  if b.len() == 0 {
    ""
  } else {
    b.join(none)
  }
}

Test 1:
    #testresult(duplicateremovals("abbaca") == "ca")

Test 2:
    #testresult(duplicateremovals("azxxzy") == "ay")

Test 3:
    #testresult(duplicateremovals("aaaaaaaa") == "")

Test 4:
    #testresult(duplicateremovals("aabccba") == "a")

Test 5:
    #testresult(duplicateremovals("abcddcba") == "")

