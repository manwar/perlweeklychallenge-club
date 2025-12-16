#let matchstring(a) = {
  let out = ()
  for x in a {
    if not out.contains(x) {
      for y in a {
        if y.len() > x.len() and y.contains(x) {
          out.push(x)
          break
        }
      }
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
    #testresult(matchstring(("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")) == ("cat", "dog", "dogcat", "rat"))

Test 2:
    #testresult(matchstring(("hello", "hell", "world", "wor", "ellow", "elloworld")) == ("hell", "world", "wor", "ellow"))

Test 3:
    #testresult(matchstring(("a", "aa", "aaa", "aaaa")) == ("a", "aa", "aaa"))

Test 4:
    #testresult(matchstring(("flower", "flow", "flight", "fl", "fli", "ig", "ght")) == ("flow", "fl", "fli", "ig", "ght"))

Test 5:
    #testresult(matchstring(("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")) == ("car", "pet", "enter", "pen", "pent"))

