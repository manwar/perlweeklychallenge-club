fun arraymedian(a: List<Int>, b: List<Int>): Double {
    var nn = ArrayList(a)
    for (n in b) {
        nn.add(n)
    }
    nn.sort()
    val i = nn.size / 2
    if (nn.size % 2 == 0) {
        return (nn[i - 1] + nn[i]).toDouble() / 2.0
    } else {
        return nn[i].toDouble()
    }
}

fun main() {

    if (arraymedian(listOf(2), listOf(4)) == 3.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraymedian(listOf(1, 2, 3), listOf(7, 8, 9, 10)) == 7.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraymedian(emptyList<Int>(), listOf(10, 20, 30, 40)) == 25.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraymedian(listOf(100), listOf(1, 2, 3, 4, 5, 6, 7)) == 4.5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraymedian(listOf(1, 2, 2), listOf(2, 2, 3)) == 2.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
