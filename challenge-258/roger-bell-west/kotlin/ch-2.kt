fun popcount64(x0: Int): Int {
    val M1  = 0x5555555555555555
    val M2  = 0x3333333333333333
    val M4  = 0x0f0f0f0f0f0f0f0f
    val H01 = 0x0101010101010101
    var x = x0.toLong()
    x -= (x shr 1) and M1
    x = (x and M2) + ((x shr 2) and M2)
    x = (x + (x shr 4)) and M4
    return ((x * H01) shr 56).toInt()
}

fun sumofvalues(a: List<Int>, k: Int ): Int {
    var s = 0
    for ((i, v) in a.withIndex()) {
        if (popcount64(i) == k) {
            s += v
        }
    }
    return s
}

fun main() {

    if (sumofvalues(listOf(2, 5, 9, 11, 3), 1) == 17) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumofvalues(listOf(2, 5, 9, 11, 3), 2) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumofvalues(listOf(2, 5, 9, 11, 3), 0) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
