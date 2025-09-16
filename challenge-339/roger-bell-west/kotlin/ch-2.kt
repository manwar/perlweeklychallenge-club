fun peakpoint(a: List<Int>): Int {
    var h = 0
    var o = 0
    for (p in a) {
        h += p
        o = listOf(o, h).maxOrNull()!!
    }
    return o
}

fun main() {

    if (peakpoint(listOf(-5, 1, 5, -9, 2)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (peakpoint(listOf(10, 10, 10, -25)) == 30) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (peakpoint(listOf(3, -4, 2, 5, -6, 1)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (peakpoint(listOf(-1, -2, -3, -4)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (peakpoint(listOf(-10, 15, 5)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
