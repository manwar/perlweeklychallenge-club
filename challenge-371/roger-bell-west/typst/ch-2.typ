#let combinations(arr, k) = {
  let c = ()
  for i in range(0, k) {
    c.push(i)
  }
  c.push(arr.len())
  c.push(0)
  let out = ()
  while true {
    let inner = ()
    for i in range(k - 1, 0 - 1, step: -1) {
      inner.push(arr.at(c.at(i)))
    }
    out.push(inner)
    let j = 0
    while true {
      if c.at(j) + 1 != c.at(j + 1) {
        break
      }
      c.at(j) = j
      j += 1
    }
    if j >= k {
      break
    }
    c.at(j) += 1
  }
  out
}

#let subsetequilibrium(a) = {
  let out = ()
  let b = ()
  for (i, x) in a.enumerate() {
    b.push(x - i - 1)
  }
  let ix = range(b.len())
  for n in range(1, b.len()) {
    for iys in combinations(ix, n) {
      let iy = iys.sorted()
      let bp = iy.map(i => b.at(i)).sum()
      if bp == 0 {
        let ap = iy.map(i => a.at(i))
        out.push(ap)
      }
    }
  }
  out.sorted()
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(subsetequilibrium((2, 1, 4, 3)) == ((1, 4), (2, 1), (2, 3), (4, 3)))

Test 2:
    #testresult(subsetequilibrium((3, 0, 3, 0)) == ((3,), (3, 0), (3, 0, 3)))

Test 3:
    #testresult(subsetequilibrium((5, 1, 1, 1)) == ((5, 1, 1),))

Test 4:
    #testresult(subsetequilibrium((3, -1, 4, 2)) == ((3, -1, 4), (3, 2)))

Test 5:
    #testresult(subsetequilibrium((10, 20, 30, 40)) == ())

