fun digitalroot(a: Int): List<Int> {
    var count = 0
    var value = a
    while (value > 9) {
        var p = 0
        while (value > 0) {
            p += value % 10
            value /= 10
        }
        value = p
        count += 1
    }
    return listOf(count, value)
}

fun main() {

    if (digitalroot(38) == listOf(2, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (digitalroot(7) == listOf(0, 7)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (digitalroot(999) == listOf(2, 9)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (digitalroot(1999999999) == listOf(3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (digitalroot(101010) == listOf(1, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
