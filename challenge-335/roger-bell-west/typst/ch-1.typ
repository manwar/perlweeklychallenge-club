#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let counterify(a) = {
  let c = (:)
  for n in a {
    c.insert(n, c.at(n, default: 0) + 1)
  }
  c
}

#let commoncharacters(a) = {
  let mc = (:)
  let first = true
  for s in a {
    let mk = counterify(s.codepoints())
    if first {
      mc = mk
      first = false
    } else {
      for k in mc.keys() {
        if k in mk {
          mc.insert(k, calc.min(mc.at(k), mk.at(k)))
        } else {
          let _ = mc.remove(k)
        }
      }
    }
  }
  let out = ()
  for c in mc.keys().sorted() {
    for _ in range(mc.at(c)) {
      out.push(c)
    }
  }
  out
}

Test 1:
    #testresult(commoncharacters(("bella", "label", "roller")) == ("e", "l", "l"))

Test 2:
    #testresult(commoncharacters(("cool", "lock", "cook")) == ("c", "o"))

Test 3:
    #testresult(commoncharacters(("hello", "world", "pole")) == ("l", "o"))

Test 4:
    #testresult(commoncharacters(("abc", "def", "ghi")) == ())

Test 5:
    #testresult(commoncharacters(("aab", "aac", "aaa")) == ("a", "a"))

