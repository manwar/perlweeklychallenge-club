#let parsetime(a) = {
  let p = a.split(":")
  int(p.at(0)) * 60 + int(p.at(1))
}

#let conflictevents(a, b) = {
  let r = ()
  for t in (a, b) {
    let st = parsetime(t.at(0))
    let en = parsetime(t.at(1))
    if st < en {
      r.push(
        (
          (st, en - 1),
        )
      )
    } else {
      r.push(
        (
          (st, 1440 - 1),
          (0, en - 1),
        )
      )
    }
  }
  let flag = false
  for ra in r.at(0) {
    for rb in r.at(1) {
      if ra.at(0) <= rb.at(1) and rb.at(0) <= ra.at(1) {
        flag = true
        break
      }
    }
  }
  flag
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(conflictevents(("10:00", "12:00"), ("11:00", "13:00")))

Test 2:
    #testresult(not conflictevents(("09:00", "10:30"), ("10:30", "12:00")))

Test 3:
    #testresult(conflictevents(("14:00", "15:30"), ("14:30", "16:00")))

Test 4:
    #testresult(not conflictevents(("08:00", "09:00"), ("09:01", "10:00")))

Test 5:
    #testresult(conflictevents(("23:30", "00:30"), ("00:00", "01:00")))

