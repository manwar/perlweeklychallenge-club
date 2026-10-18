#let wordsquares(a) = {
  let l = a.at(0).len()
  let words = a.map(w => (w, true)).to-dict()
  let queue = ()
  for w in a {
    queue.push((w,))
  }
  let ret = []
  while queue.len() > 0 {
    let p = queue.remove(0)
    if p.len() == l {
      ret = p
      break
    }
    let pd = p.map(w => (w, true)).to-dict()
    for ca in words.keys() {
      if not(ca in pd) {
        let valid = true
        for (i, c) in ca.clusters().enumerate() {
          if i >= p.len() {
            break
          }
          if c != p.at(i).at(p.len()) {
            valid = false
            break
          }
        }
        if valid {
          let pw = p
          pw.push(ca)
          queue.push(pw)
        } 
     }
    }
  }
  ret
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(wordsquares(("MA", "AM", "MY", "ME")) == ("MA", "AM"))

Test 2:
    #testresult(wordsquares(("SUN", "USE", "NET", "SEE", "TEN")) == ("SUN", "USE", "NET"))

Test 3:
    #testresult(wordsquares(("BOAT", "TEAL", "AREA", "TSAR", "OGRE")) == ("BOAT", "OGRE", "AREA", "TEAL"))

Test 4:
    #testresult(wordsquares(("CARD", "AREA", "REAR", "DART")) == ("CARD", "AREA", "REAR", "DART"))

Test 5:
    #testresult(wordsquares(("HEART", "TREND", "EMBER", "RESIN", "ABUSE")) == ("HEART", "EMBER", "ABUSE", "RESIN", "TREND"))

