#let maxwords(a) = {
  calc.max(..a.map(x => x.split(" ").len()))
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(maxwords(("Hello world", "This is a test", "Perl is great")) == 4)

Test 2:
    #testresult(maxwords(("Single",)) == 1)

Test 3:
    #testresult(maxwords(("Short", "This sentence has six words in total", "A B C", "Just four words here")) == 7)

Test 4:
    #testresult(maxwords(("One", "Two parts", "Three part phrase", "")) == 3)

Test 5:
    #testresult(maxwords(("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")) == 10)

