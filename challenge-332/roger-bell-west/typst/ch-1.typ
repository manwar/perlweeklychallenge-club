#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let inttobins(n) = {
  if n == 0 {
    "0"
  } else {
    let d = ()
    let m = n
    while m > 0 {
      if m.bit-and(1) == 1 {
        d.insert(0, "1")
      } else {
        d.insert(0, "0")
      }
      m = calc.quo(m, 2)
    }
    d.join("")
  }
}

#let binarydate(a) = {
  a.split("-").map(n => inttobins(int(n))).join("-")
}

Test 1:
    #testresult(binarydate("2025-07-26") == "11111101001-111-11010")

Test 2:
    #testresult(binarydate("2000-02-02") == "11111010000-10-10")

Test 3:
    #testresult(binarydate("2024-12-31") == "11111101000-1100-11111")

