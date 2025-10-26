#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let arrayformation(src, tgt) = {
  let stack = ()
  let d = (:)
  for n in range(src.len()) {
    d.insert(str(n), true)
  }
  stack.push(((), d))
  let ret = false
  while stack.len() > 0 {
    let c = stack.pop()
    if c.at(0).len() == tgt.len() {
      ret = true
      stack = ()
    } else {
      for candidate in c.at(1).keys() {
        let offset = c.at(0).len()
        let nextcandidate = c.at(1).keys().filter(x => x != candidate).map(x => (x, true)).to-dict()
        let valid = true
        let seq = c.at(0).map(x => x)
        for (i, x) in src.at(int(candidate)).enumerate() {
          if x == tgt.at(i + offset) {
            seq.push(x)
          } else {
            valid = false
            break
          }
        }
        if valid {
          stack.push((seq, nextcandidate))
        }
      }
    }
  }
  ret
}

Test 1:
    #testresult(arrayformation(((2, 3), (1, ), (4, )), (1, 2, 3, 4)))

Test 2:
    #testresult(not arrayformation(((1, 3), (2, 4)), (1, 2, 3, 4)))

Test 3:
    #testresult(arrayformation(((9, 1), (5, 8), (2, )), (5, 8, 2, 9, 1)))

Test 4:
    #testresult(not arrayformation(((1, ), (3, )), (1, 2, 3)))

Test 5:
    #testresult(arrayformation(((7, 4, 6), ), (7, 4, 6)))

