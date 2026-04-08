#let isqrt(s) = {
  if s <= 1 {
    s
  } else {
    let x0 = calc.div-euclid(s, 2)
    let x1 = calc.div-euclid(x0 + calc.div-euclid(s, x0), 2)
    while x1 < x0 {
      x0 = x1
      x1 = calc.div-euclid(x0 + calc.div-euclid(s, x0), 2)
    }
    x0
  }
}

#let genprimes(mx) = {
  let primesh = (("2", true), ("3", true)).to-dict()
  for i in range(6, mx, step: 6) {
    for j in (i - 1, i + 1) {
      if j < mx {
        primesh.insert(str(j), true)
      }
    }
  }
  let q = (2, 3, 5, 7)
  let p = q.remove(0)
  let mr = isqrt(mx)
  while p <= mr {
    if str(p) in primesh {
      for i in range(p * p, mx + 1, step: p) {
        let _ = primesh.remove(str(i), default: "")
      }
    }
    if q.len() < 2 {
      let t = q.at(0) + 4
      q.push(t)
      q.push(t + 2)
    }
    p = q.remove(0)
  }
  primesh.keys().map(x => int(x)).sorted()
}

#let primefactor(n) = {
  let f = (:)
  let m = n
  for p in genprimes(1 + isqrt(n)) {
    while calc.rem-euclid(m, p) == 0 {
      m = calc.div-euclid(m, p)
      let e = f.at(str(p), default: 0)
      f.insert(str(p), e + 1)
    }
    if m == 1 {
      break
    }
  }
  if m > 1 {
    let e = f.at(str(m), default: 0)
    f.insert(str(m), e + 1)
  }
  f
}

#let omega(a, mode) = {
  let pf = primefactor(a)
  if mode == 0 {
    pf.len()
  } else {
    pf.values().sum()
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
    #testresult(omega(100061, 0) == 3)

Test 2:
    #testresult(omega(971088, 0) == 3)

Test 3:
    #testresult(omega(63640, 1) == 6)

Test 4:
    #testresult(omega(988841, 1) == 2)

Test 5:
    #testresult(omega(211529, 0) == 2)

