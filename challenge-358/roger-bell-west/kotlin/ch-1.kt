fun strvalue(a: String): Int {
    val n = a.toIntOrNull()
    if (n == null) {
        return a.length
    } else {
        return n
    }
}

fun maxstrvalue(a: List<String>): Int {
    return a.map {strvalue(it)}.maxOrNull()!!
}

fun main() {
    if (maxstrvalue(listOf("123", "45", "6")) == 123) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxstrvalue(listOf("abc", "de", "fghi")) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxstrvalue(listOf("0012", "99", "a1b2c")) == 99) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxstrvalue(listOf("x", "10", "xyz", "007")) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxstrvalue(listOf("hello123", "2026", "perl")) == 2026) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
