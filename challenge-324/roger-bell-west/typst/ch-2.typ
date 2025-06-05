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

#let totalxor(i) = {
  let tot = 0
  for n in range(1, i.len() + 1) {
    for l in combinations(i, n) {
      tot += l.reduce((a, b) => a.bit-xor(b))
    }
  }
  tot
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(totalxor((1, 3)) == 6)

Test 2:
    #testresult(totalxor((5, 1, 6)) == 28)

Test 3:
    #testresult(totalxor((3, 4, 5, 6, 7, 8)) == 480)

