#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let hm2m(a) = {
  let p = a.split(":")
  int(p.at(0)) * 60 + int(p.at(1))
}

#let converttime(ssrc, ttgt) = {
  let src = hm2m(ssrc)
  let tgt = hm2m(ttgt)
  if tgt < src {
    tgt += 24 * 60
  }
  let delta = tgt - src
  let oc = 0
  for op in (60, 15, 5, 1) {
    oc += calc.div-euclid(delta, op)
    delta = calc.rem-euclid(delta, op)
  }
  oc
}

Test 1:
    #testresult(converttime("02:30", "02:45") == 1)

Test 2:
    #testresult(converttime("11:55", "12:15") == 2)

Test 3:
    #testresult(converttime("09:00", "13:00") == 4)

Test 4:
    #testresult(converttime("23:45", "00:30") == 3)

Test 5:
    #testresult(converttime("14:20", "15:25") == 2)

