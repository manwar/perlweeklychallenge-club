#let specialaverage(a0) = {
  let a = a0.sorted()
  let min = a.first()
  let max = a.last()
  let b = a.filter(x => x != min and x != max)
  if b.len() == 0 {
    0
  } else {
    b.sum() / b.len()
  }
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(specialaverage((8000, 5000, 6000, 2000, 3000, 7000)) == 5250)

Test 2:
    #testresult(specialaverage((100000, 80000, 110000, 90000)) == 95000)

Test 3:
    #testresult(specialaverage((2500, 2500, 2500, 2500)) == 0)

Test 4:
    #testresult(specialaverage((2000, )) == 0)

Test 5:
    #testresult(specialaverage((1000, 2000, 3000, 4000, 5000, 6000)) == 3500)

