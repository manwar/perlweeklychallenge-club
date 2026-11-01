#let reflect(a) = {
    let p = ()
    let am = a
    while true {
        p.push(calc.rem-euclid(am, 2))
        am = am.bit-rshift(1, logical: true)
        if am == 0 {
            break
        }
    }
    let ar = 0
    let s = p.len()
    for n in p {
        s -= 1
        ar += n.bit-lshift(s)
    }
    ar
}

#let binaryreflection(ax) = {
    let k = ax.map(x => reflect(x))
    let i = range(ax.len()).sorted(key: s => ax.at(s)).sorted(key: s => k.at(s))
    i.map(x => ax.at(x))
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(binaryreflection((3, 6, 12)) == (3, 6, 12))

Test 2:
    #testresult(binaryreflection((1, 2, 4, 8)) == (1, 2, 4, 8))

Test 3:
    #testresult(binaryreflection((7, 8, 9, 10)) == (8, 10, 7, 9))

Test 4:
    #testresult(binaryreflection((5, 9, 15, 17)) == (5, 9, 15, 17))

Test 5:
    #testresult(binaryreflection((11, 13, 14, 19)) == (14, 13, 11, 19))

