fun cleardigits(a: String): String {
    var out = ArrayList<Char>()
    for (c in a.toCharArray()) {
        if (c.isDigit()) {
            out = ArrayList(out.dropLast(1))
        } else {
            out.add(c)
        }
    }
    return out.joinToString("")
}

fun main() {

    if (cleardigits("cab12") == "c") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (cleardigits("xy99") == "") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (cleardigits("pa1erl") == "perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
