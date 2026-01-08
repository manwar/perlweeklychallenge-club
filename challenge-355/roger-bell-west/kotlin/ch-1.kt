fun thousandseparator(a: Int): String {
    var out = ""
    val s = a.toString()
    val offset = 2 - ((s.length + 2) % 3)
    s.toList().forEachIndexed { i, d ->
                                    if (i > 0 && (i + offset) % 3 == 0) {
                                        out += ','
                                    }
                                out += d
    }
    return out
}

fun main() {

    if (thousandseparator(123) == "123") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thousandseparator(1234) == "1,234") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thousandseparator(1000000) == "1,000,000") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thousandseparator(1) == "1") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thousandseparator(12345) == "12,345") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
