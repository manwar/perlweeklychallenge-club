#let stringdifference(a) = {
    let da = ()
    for s in a {
        let p = ()
        for d in s.codepoints().windows(2) {
            p.push(str.to-unicode(d.at(1)) - str.to-unicode(d.at(0)))
        }
        da.push(p)
    }
    let dx = 0
    for b in range(1, a.len()) {
        if da.at(0) != da.at(b) {
            if dx > 0 {
                dx = 0
                break
            } else {
                dx = b
            }
        }
    }
    a.at(dx)
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(stringdifference(("ab", "bc", "cd", "zy")) == "zy")

Test 2:
    #testresult(stringdifference(("cba", "fed", "azy")) == "azy")

Test 3:
    #testresult(stringdifference(("pop", "ada", "beb", "cfc")) == "pop")

Test 4:
    #testresult(stringdifference(("aaaa", "zzzz", "mmmm", "aaba")) == "aaba")

Test 5:
    #testresult(stringdifference(("aceg", "bdfh", "cegi", "azbz")) == "azbz")

