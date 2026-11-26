#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}


#let rat_reduce(a) = {
    let d = calc.gcd(a.at(0), a.at(1))
    (calc.quo(a.at(0), d), calc.quo(a.at(1), d))
}

#let rat_add(a, b) = {
    let nd = calc.lcm(a.at(1), b.at(1))
    let nn = calc.quo(a.at(0)*nd, a.at(1)) + calc.quo(b.at(0)*nd, b.at(1))
    rat_reduce((nn, nd))
}

#let rat_mul(a, b) = {
    rat_reduce((a.at(0) * b.at(0), a.at(1) * b.at(1)))
}

#let rat_stringify(a) = {
    let aa0 = a.at(0);
    let s = ""
    if a.at(0) < 0 {
        s = "-"
        aa0 = -aa0
    }
    s + str(aa0) + "/" + str(a.at(1))
}

#let fractionaladditionsubstraction(a) = {
    let terms = ()
    let state = 0
    let n = 0
    let num = 0
    let sign = 0
    let i = 0
    while i < a.len() {
        if state == 0 {
            if a.at(i) == "+" {
                state = 0
                i += 1
            } else if a.at(i) >= "0" and a.at(i) <= "9" {
                sign = 1
                state = 1
                n = int(a.at(i))
                i += 1
            } else if a.at(i) == "-" {
                sign = -1
                state = 1
                n = 0
                i += 1
            }
        } else if state == 1 {
            if a.at(i) >= "0" and a.at(i) <= "9" {
                n = n * 10 + int(a.at(i))
                i += 1
            } else if a.at(i) == "/" {
                num = n * sign
                n = 0
                state = 2
                i += 1
            }
        } else if state == 2 {
            if a.at(i) >= "0" and a.at(i) <= "9" {
                n = n * 10 + int(a.at(i))
                i += 1
            } else {
                terms.push((num, n))
                state = 0
            }
        }
    }
    if state == 2 {
                terms.push((num, n))
    }
    let out = terms.remove(0)
    for nt in terms {
        out = rat_add(out, nt)
    }
    rat_stringify(out)
}

Test 1:
    #testresult(fractionaladditionsubstraction("1/2+3/2") == "2/1")

Test 2:
    #testresult(fractionaladditionsubstraction("-5/2-3/2") == "-4/1")

Test 3:
    #testresult(fractionaladditionsubstraction("5/3-5/3") == "0/1")

Test 4:
    #testresult(fractionaladditionsubstraction("10/10-1/10+2/5") == "13/10")

Test 5:
    #testresult(fractionaladditionsubstraction("1/6+1/6+1/6") == "1/2")

