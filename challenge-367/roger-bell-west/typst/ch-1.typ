#let maxoddbinary(a) = {
  let ones = 0
  let zeroes = 0
  for c in a.codepoints() {
    if c == "0" {
      zeroes += 1
    } else if c == "1" {
      ones += 1
    }
  }
  if ones < 1 {
    ""
  } else {
    let out = ""
    for _ in range(ones - 1) {
      out += "1"
    }
    for _ in range(zeroes) {
      out += "0"
    }
    out += "1"
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
    #testresult(maxoddbinary("1011") == "1101")

Test 2:
    #testresult(maxoddbinary("100") == "001")

Test 3:
    #testresult(maxoddbinary("111000") == "110001")

Test 4:
    #testresult(maxoddbinary("0101") == "1001")

Test 5:
    #testresult(maxoddbinary("1111") == "1111")

