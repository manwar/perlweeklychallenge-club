fun validtag(a: String): String {
    var p = "#"
    var up = false
    for (c in a.toList()) {
        if (c.isLetter()) {
            var cc = c
            if (up) {
                cc = cc.uppercaseChar()
                up = false
            } else {
                cc = cc.lowercaseChar()
            }
            p += cc
        } else if (c == ' ' && p.length > 1) {
            up = true
        }
    }
    if (p.length > 100) {
        p = p.slice(0 .. 99)
    }
    return p
}

fun main() {

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
