fun buddystrings(a: String, b: String): Boolean {
    val ac = a.toCharArray().toList()
    val bc = b.toCharArray().toList()
    for (i in 0 .. a.length - 2) {
        for (j in i + 1 .. a.length - 1) {
            var acx = ArrayList(ac)
            acx[i] = ac[j]
            acx[j] = ac[i]
            if (acx.toList() == bc) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (buddystrings("fuck", "fcuk")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!buddystrings("love", "love")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (buddystrings("fodo", "food")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (buddystrings("feed", "feed")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
