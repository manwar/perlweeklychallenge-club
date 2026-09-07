#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let secretsanta(n) = {
  if n == 0 {
    1
  } else if n == 1 {
    0
  } else {
    (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2))
  }
}

Test 1:
    #testresult(secretsanta(1) == 0)

Test 2:
    #testresult(secretsanta(2) == 1)

Test 3:
    #testresult(secretsanta(3) == 2)

Test 4:
    #testresult(secretsanta(4) == 9)

Test 5:
    #testresult(secretsanta(5) == 44)

