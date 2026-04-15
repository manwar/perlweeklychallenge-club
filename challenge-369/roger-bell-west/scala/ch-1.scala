
object Validtag {
  def validtag(a: String): String = {
    var p = "#"
    var up = false
    for (c <- a.toList) {
      if (c.isLetter) {
        var cc = c
        if (up) {
          cc = cc.toUpper
          up = false
        } else {
          cc = cc.toLower
        }
        p += cc
      } else if (c == ' ' && p.length > 1) {
        up = true
      }
    }
    if (p.length > 100) {
      p = p.slice(0, 100)
    }
    p
  }
  def main(args: Array[String]) {
    if (validtag("Cooking with 5 ingredients!") == "#cookingWithIngredients") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtag("the-last-of-the-mohicans") == "#thelastofthemohicans") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtag("  extra spaces here") == "#extraSpacesHere") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtag("iPhone 15 Pro Max Review") == "#iphoneProMaxReview") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!") == "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
