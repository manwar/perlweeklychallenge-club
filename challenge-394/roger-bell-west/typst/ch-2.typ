#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

#let common_substring(a0) = {
  let a = a0.sorted(key: s => s.len())
  let results = ()
  for l in range(1, a.at(0).len()).rev() {
    for offset in range(a.at(0).len() - l + 1) {
      let m = true
      let sample = a.at(0).slice(offset, count: l)
      for axi in range(1, a.len()) {
        if a.at(axi).find(sample) == none {
          m = false
          break
        }
      }
      if m {
        results.push(sample)
      }
    }
  }
  results
}

#let is_avc(a) = {
  let valid = true
  let laststate = false
  for (i, c) in a.codepoints().enumerate() {
    let thisstate = false
    if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" {
      thisstate = true
    }
    if i > 0 and thisstate == laststate {
      valid = false
      break
    }
    laststate = thisstate
  }
  valid
}

#let alternatingvowelsconsonants(a) = {
  let c2 = common_substring(a).filter(w => is_avc(w))
  if c2.len() > 0 {
    let l = c2.at(0).len()
    c2.filter(w => w.len() == l)
  } else {
    ()
  }
}

Test 1:
    #testresult(alternatingvowelsconsonants(("relocate", "delocate", "allocate")) == ("locate",))

Test 2:
    #testresult(alternatingvowelsconsonants(("apple", "banana", "cherry")) == ())

Test 3:
    #testresult(alternatingvowelsconsonants(("navigate", "cavity", "gravity")) == ("avi",))

Test 4:
    #testresult(alternatingvowelsconsonants(("pedalgia", "pedalboard", "pedantic")) == ("peda",))

Test 5:
    #testresult(alternatingvowelsconsonants(("schoolmaster", "schoolhouse", "schooling")) == ("ho", "ol"))

