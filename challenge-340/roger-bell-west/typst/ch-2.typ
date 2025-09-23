#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let ascendingnumbers(a) = {
  let first = true
  let prev = 0
  let ret = true
  for c in a.split(" ") {
    if c.match(regex("^[0-9]+$")) != none {
      let n = int(c)
      if first == false and prev >= n {
        ret = false
      }
      prev = n
      first = false
    }
  }
  ret
}

Test 1:
    #testresult(ascendingnumbers("The cat has 3 kittens 7 toys 10 beds"))

Test 2:
    #testresult(not ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas"))

Test 3:
    #testresult(ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months"))

Test 4:
    #testresult(not ascendingnumbers("Bob has 10 cars 10 bikes"))

Test 5:
    #testresult(ascendingnumbers("Zero is 0 one is 1 two is 2"))

