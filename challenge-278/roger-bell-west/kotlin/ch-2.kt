fun reverseword(a: String, c: Char): String {
    val m = a.indexOf(c)
    if (m == -1) {
        return a
    }
    var b = ArrayList(a.slice(0 .. m).split(""))
    b.sort()
    b.addAll(a.slice(m + 1 .. a.length - 1).split(""))
    return b.joinToString("")
}

fun main() {

    if (reverseword("challenge", 'e') == "acehllnge") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseword("programming", 'a') == "agoprrmming") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseword("champion", 'b') == "champion") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
