#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let wordcount(a) = {
  let ct = 0
  for w in a {
    if  w.starts-with(regex("[aeiou]")) or w.ends-with(regex("[aeiou]")) {
      ct += 1
    }
  }
  ct
}

Test 1: #testresult(wordcount(("unicode", "xml", "raku", "perl")) == 2)

Test 2: #testresult(wordcount(("the", "weekly", "challenge")) == 2)

Test 3: #testresult(wordcount(("perl", "python", "postgres")) == 0)
