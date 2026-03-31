#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let countprefixes(a, b) = {
  a.filter(x => b.starts-with(x)).len()
}

Test 1:
    #testresult(countprefixes(("a", "ap", "app", "apple", "banana"), "apple") == 4)

Test 2:
    #testresult(countprefixes(("cat", "dog", "fish"), "bird") == 0)

Test 3:
    #testresult(countprefixes(("hello", "he", "hell", "heaven", "he"), "hello") == 4)

Test 4:
    #testresult(countprefixes(("", "code", "coding", "cod"), "coding") == 3)

Test 5:
    #testresult(countprefixes(("p", "pr", "pro", "prog", "progr", "progra", "program"), "program") == 7)

