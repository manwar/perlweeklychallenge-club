#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let formatphonenumber(a) = {
  let pure = a.split("").filter(x => x >= "0" and x <= "9")
  let left = pure.len()
  let out = ()
  let i = 0
  if left > 4 {
    for c in pure {
      out.push(c)
      i += 1
      left -= 1
      if calc.rem-euclid(i, 3) == 0 {
        out.push("-")
        if left <= 4 {
          break
        }
      }
    }
  }
  if left == 4 {
    out.push(pure.at(i))
    out.push(pure.at(i + 1))
    out.push("-")
    i += 2
  }
  for p in range(i, pure.len()) {
    out.push(pure.at(p))
  }
  out.join("")
}

Test 1:
    #testresult(formatphonenumber("1-23-45-6") == "123-456")

Test 2:
    #testresult(formatphonenumber("1234") == "12-34")

Test 3:
    #testresult(formatphonenumber("12 345-6789") == "123-456-789")

Test 4:
    #testresult(formatphonenumber("123 4567") == "123-45-67")

Test 5:
    #testresult(formatphonenumber("123 456-78") == "123-456-78")

