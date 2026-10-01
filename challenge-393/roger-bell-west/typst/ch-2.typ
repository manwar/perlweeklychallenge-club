#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

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

#let primestep(a) = {
  let g = a.clusters().map(c => c.to-unicode()).sum()
  let pm = genprimes(g * 2)
  let lo = pm.filter(x => x <= g).last()
  let hi = pm.filter(x => x > g).first()
  calc.min(g - lo, hi - g)
}

Test 1:
    #testresult(primestep("hello") == 9)

Test 2:
    #testresult(primestep("football") == 2)

Test 3:
    #testresult(primestep("a") == 0)

Test 4:
    #testresult(primestep("challenge") == 2)

Test 5:
    #testresult(primestep("perl") == 2)

