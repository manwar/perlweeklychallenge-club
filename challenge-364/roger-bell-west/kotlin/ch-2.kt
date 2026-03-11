fun goalparser(a: String): String {
    var out = ""
    var s = 0
    while (s < a.length) {
        if (a.substring(s).startsWith("G")) {
            s += 1
            out += "G"
        } else if (a.substring(s).startsWith("()")) {
            s += 2
            out += "o"
        } else if (a.substring(s).startsWith("(al)")) {
            s += 4
            out += "al"
        } else {
            return ""
        }
    }
    return out
}

fun main() {

    if (goalparser("G()(al)") == "Goal") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goalparser("G()()()()(al)") == "Gooooal") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goalparser("(al)G(al)()()") == "alGaloo") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goalparser("()G()G") == "oGoG") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goalparser("(al)(al)G()()") == "alalGoo") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
