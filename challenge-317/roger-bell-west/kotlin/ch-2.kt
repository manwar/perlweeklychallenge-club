fun friendlystrings(a: String, b: String): Boolean {
    val aa = a.toCharArray()
    for (i in 0 .. a.length - 2) {
        for (j in i + 1 .. a.length - 1) {
            var cc = a.toCharArray()
            cc[i] = aa[j]
            cc[j] = aa[i]
            if (cc.joinToString("") == b) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (friendlystrings("desc", "dsec")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (friendlystrings("fuck", "fcuk")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!friendlystrings("poo", "eop")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (friendlystrings("stripe", "sprite")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
