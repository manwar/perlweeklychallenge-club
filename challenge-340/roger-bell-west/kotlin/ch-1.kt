fun duplicateremovals(a: String): String {
    var b = ArrayList<Char>()
    for (c in a.toCharArray()) {
        if (b.size == 0 || c != b[b.size - 1]) {
            b.add(c)
        } else {
            b = ArrayList(b.dropLast(1))
        }
    }
    return b.joinToString("")
}

fun main() {

    if (duplicateremovals("abbaca") == "ca") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateremovals("azxxzy") == "ay") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateremovals("aaaaaaaa") == "") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateremovals("aabccba") == "a") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateremovals("abcddcba") == "") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
