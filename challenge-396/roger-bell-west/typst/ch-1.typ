#let finishingorder(order, friends) = {
  order.filter(x => x in friends)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(finishingorder((3, 1, 4, 2, 5), (1, 4, 2)) == (1, 4, 2))

Test 2:
    #testresult(finishingorder((5, 4, 3, 2, 1), (1, 3, 5)) == (5, 3, 1))

Test 3:
    #testresult(finishingorder((2, 4, 1, 3), (1, 2, 3, 4)) == (2, 4, 1, 3))

Test 4:
    #testresult(finishingorder((4, 1, 3, 2), (3,)) == (3,))

Test 5:
    #testresult(finishingorder((1, 3, 2, 6, 5, 4), (1, 2, 3)) == (1, 3, 2))

