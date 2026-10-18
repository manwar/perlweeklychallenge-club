fun parsecomplex(a: String): Pair<Int, Int> {
    val re = "^\\(?([-0-9]+)\\)?\\+\\(?([-0-9]+)\\)?i$".toRegex()
    val mr = re.find(a)
    if (mr != null) {
        return Pair(mr.groupValues[1].toInt(), mr.groupValues[2].toInt())
    } else {
        return Pair(0, 0)
    }
}

fun complexnumber(aa: String, bb: String): String {
    val (a, b) = parsecomplex(aa)
    val (c, d) = parsecomplex(bb)
    val ca = a * c - b * d
    val cb = a * d + b * c
    if (cb >= 0) {
        return ca.toString() + "+" + cb.toString() + "i"
    } else {
        return ca.toString() + "+(" + cb.toString() + ")i"
    }
}

  fun main() {

    if (complexnumber("1+1i", "1+1i") == "0+2i") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (complexnumber("1+(-1)i", "1+(-1)i") == "0+(-2)i") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (complexnumber("0+3i", "0+4i") == "-12+0i") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (complexnumber("3+4i", "3+(-4)i") == "25+0i") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (complexnumber("50+-20i", "-10+30i") == "100+1700i") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
