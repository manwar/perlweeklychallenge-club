fun arithmeticprogression(a0: List<Double>): Boolean {
    val epsilon = 0.0001
    val a = a0.sorted()
    val delta = a[1] - a[0]
    for (v in a.drop(1).windowed(size = 2)) {
        if (Math.abs(v[1] - v[0] - delta) > epsilon) {
            return false
        }
    }
    return true
}

fun main() {

    if (arithmeticprogression(listOf(1.0, 3.0, 5.0, 7.0, 9.0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arithmeticprogression(listOf(9.0, 1.0, 7.0, 5.0, 3.0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!arithmeticprogression(listOf(1.0, 2.0, 4.0, 8.0, 16.0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arithmeticprogression(listOf(5.0, -1.0, 3.0, 1.0, -3.0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arithmeticprogression(listOf(1.5, 3.0, 0.0, 4.5, 6.0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
