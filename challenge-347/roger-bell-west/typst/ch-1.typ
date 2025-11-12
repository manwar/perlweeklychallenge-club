#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let fmn(a, n) = {
  let ap = str(a)
  while ap.len() < n {
    ap = "0" + ap
  }
  ap
}

#let formatdate(a) = {
  let dmy = a.match(regex("([0-9]+)[a-z]+ ([A-Z][a-z]{2}) ([0-9]+)")).captures
  dmy.at(1) = (
    ("Jan" , 1),
    ("Feb" , 2),
    ("Mar" , 3),
    ("Apr" , 4),
    ("May" , 5),
    ("Jun" , 6),
    ("Jul" , 7),
    ("Aug" , 8),
    ("Sep" , 9),
    ("Oct" , 10),
    ("Nov" , 11),
    ("Dec" , 12),
  ).to-dict().at(dmy.at(1))
  (
    fmn(int(dmy.at(2)), 4),
    fmn(dmy.at(1), 2),
    fmn(int(dmy.at(0)), 2)
  ).join("-")
}

Test 1:
    #testresult(formatdate("1st Jan 2025") == "2025-01-01")

Test 2:
    #testresult(formatdate("22nd Feb 2025") == "2025-02-22")

Test 3:
    #testresult(formatdate("15th Apr 2025") == "2025-04-15")

Test 4:
    #testresult(formatdate("23rd Oct 2025") == "2025-10-23")

Test 5:
    #testresult(formatdate("31st Dec 2025") == "2025-12-31")

