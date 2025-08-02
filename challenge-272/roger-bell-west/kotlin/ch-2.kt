fun stringscore(a: String): Int {
    var out = 0
    for (i in a.toList().windowed(size = 2)) {
        out += Math.abs(i[0].code - i[1].code)
    }
    return out
}

fun main() {

    if (stringscore("hello") == 13) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringscore("perl") == 30) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringscore("raku") == 37) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
