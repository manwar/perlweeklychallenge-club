#let samerowcolumn(a) = {
  let ret = true
  for row in a {
    let notfound = range(1, row.len() + 1).map(x => (str(x), true)).to-dict()
    for n in row {
      let _ = notfound.remove(str(n), default: false)
    }
    if notfound.len() > 0 {
      ret = false
      break
    }
  }
  if ret {
    for coln in range(a.at(0).len()) {
      let notfound = range(1, a.len() + 1).map(x => (str(x), true)).to-dict()
      for row in a {
        let _ = notfound.remove(str(row.at(coln)), default: false)
      }
      if notfound.len() > 0 {
        ret = false
        break
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
    #testresult(samerowcolumn(((1, 2, 3, 4), (2, 3, 4, 1), (3, 4, 1, 2), (4, 1, 2, 3))))

Test 2:
    #testresult(samerowcolumn(((1,),)))

Test 3:
    #testresult(not samerowcolumn(((1, 2, 5), (5, 1, 2), (2, 5, 1))))

Test 4:
    #testresult(not samerowcolumn(((1, 2, 3), (1, 2, 3), (1, 2, 3))))

Test 5:
    #testresult(not samerowcolumn(((1, 2, 3), (3, 1, 2), (3, 2, 1))))

