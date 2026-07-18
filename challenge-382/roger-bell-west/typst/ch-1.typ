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

#let is_adjacentsquared(param, hc) = {
  let ret = true
  let hcs = hc.sorted()
  if hcs != range(1, param + 1) {
    ret = false
  }
  if ret {
    for i in range(param - 1) {
      let pn = hc.at(i) + hc.at(i + 1)
      let sn = isqrt(pn)
      if pn != sn * sn {
        ret = false
        break
      }
    }
  }
  if ret {
    let pn = hc.at(0) + hc.last()
    let sn = isqrt(pn)
    if pn != sn * sn {
      ret = false
    }
  }
  ret
}

#let hamiltoniancycle(a) = {
  if a < 31 {
    ()
  } else {
    let perfectsquares = (:)
    let lim = a * 2
    for p in range(1, a + 1) {
      let ps = p * p
      if ps > lim {
        break
      }
      perfectsquares.insert(str(ps), true)
    }
    let neighbours = (:)
    for x in range(1, a + 1) {
      for y in perfectsquares.keys().map(p => int(p)) {
        if y > x {
          let z = y - x
          if z <= a {
            let stx = str(x)
            let stz = str(z)
            let s = neighbours.at(stx, default: (:))
            s.insert(str(z), true)
            neighbours.insert(stx, s)
            s = neighbours.at(stz, default: (:))
            s.insert(str(x), true)
            neighbours.insert(stz, s)
          }
        }
      }
    }
    let out = ()
    let stack = ()
    stack.push((1,))
    for _ in range(500000) {
      if stack.len() > 0 {
        let lst = stack.pop()
        if lst.len() == a {
          if str(lst.at(0) + lst.last()) in perfectsquares {
            out = lst
            stack = ()
          }
        } else {
          for candidate in neighbours.at(str(lst.last())).keys().map(x => int(x)) {
            if not lst.contains(candidate) {
              let nlst = array(lst)
              nlst.push(candidate)
              stack.push(nlst)
            }
          }
        }
      } else {
        break
      }
    }
    out
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
    #testresult(is_adjacentsquared(32, hamiltoniancycle(32)))

Test 2:
    #testresult(hamiltoniancycle(15) == ())

Test 3:
    #testresult(is_adjacentsquared(34, hamiltoniancycle(34)))
