#let validtag(a) = {
  let p = "#"
  let up = false
  let re = regex("[A-Za-z]")
  for c in a {
    if c.find(re) != none {
      let cc = c
      if up {
        cc = upper(cc)
        up = false
      } else {
        cc = lower(cc)
      }
      p += cc
    } else if c == " " and p.len() > 1 {
      up = true
    }
  }
  if p.len() > 100 {
    p = p.slice(0, 100)
  }
  p
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(validtag("Cooking with 5 ingredients!") == "#cookingWithIngredients")

Test 2:
    #testresult(validtag("the-last-of-the-mohicans") == "#thelastofthemohicans")

Test 3:
    #testresult(validtag("  extra spaces here") == "#extraSpacesHere")

Test 4:
    #testresult(validtag("iPhone 15 Pro Max Review") == "#iphoneProMaxReview")

Test 5:
    #testresult(validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!") == "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn")

