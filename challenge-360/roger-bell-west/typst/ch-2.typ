#let wordsorter(a) = {
  a.split(regex(" +")).sorted(key: x => lower(x)).join(" ")
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(wordsorter("The quick brown fox") == "brown fox quick The")

Test 2:
    #testresult(wordsorter("Hello    World!   How   are you?") == "are Hello How World! you?")

Test 3:
    #testresult(wordsorter("Hello") == "Hello")

Test 4:
    #testresult(wordsorter("Hello, World! How are you?") == "are Hello, How World! you?")

Test 5:
    #testresult(wordsorter("I have 2 apples and 3 bananas!") == "2 3 and apples bananas! have I")

