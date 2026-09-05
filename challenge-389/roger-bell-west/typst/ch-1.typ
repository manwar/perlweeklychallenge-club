#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let reordernotes(composer, notes, order) = {
  let out = range(order.len()).map(x => "")
  for (i, n) in order.enumerate() {
    out.at(n - 1) = notes.at(i)
  }
  ((composer, out),).to-dict()
}

Test 1:
    #testresult(reordernotes("Mozart", ("C", "D", "E", "F", "G", "A", "B"), (7, 1, 6, 2, 5, 3, 4)) == ("Mozart": ("D", "F", "A", "B", "G", "E", "C")))

Test 2:
    #testresult(reordernotes("Chopin", ("C", "C#", "D", "D#", "E", "F"), (6, 5, 4, 3, 2, 1)) == ("Chopin": ("F", "E", "D#", "D", "C#", "C")))

Test 3:
    #testresult(reordernotes("Vivaldi", ("A", "B", "C", "D", "E"), (1, 2, 3, 4, 5)) == ("Vivaldi": ("A", "B", "C", "D", "E")))

Test 4:
    #testresult(reordernotes("Debussy", ("C", "D", "F", "G", "A"), (1, 3, 5, 2, 4)) == ("Debussy": ("C", "G", "D", "A", "F")))

Test 5:
    #testresult(reordernotes("Stravinsky", ("C#",), (1,)) == ("Stravinsky": ("C#",)))

