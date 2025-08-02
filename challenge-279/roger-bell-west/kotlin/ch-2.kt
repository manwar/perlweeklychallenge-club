fun splitstring(a: String): Boolean {
    var n = 0
    for (cc in a.lowercase().toList()) {
        n += when (cc) {
            'a', 'e', 'i', 'o', 'u' -> 1
            else -> 0
        }
    }
    return n % 2 == 0
}

fun main() {

    if (!splitstring("perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (splitstring("book")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (splitstring("goodmorning")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
