fun reverseletters(a: String): String {
    var vout = ArrayList(a.toList())
    var letterslots = ArrayList<Int>()
    var letters = ArrayList<Char>()
    a.toList().forEachIndexed {i, c ->
                                   if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
                                       letterslots += i
                                       letters.add(c)
                                   } else {
                                       vout[i] = c
                                   }
    }
    for (i in letterslots) {
        vout[i] = letters.removeLast()
    }
    return vout.joinToString("")
}

fun main() {

    if (reverseletters("p-er?l") == "l-re?p") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseletters("wee-k!L-y") == "yLk-e!e-w") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseletters("_c-!h_all-en!g_e") == "_e-!g_nel-la!h_c") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
