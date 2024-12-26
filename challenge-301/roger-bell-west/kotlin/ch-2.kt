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

fun hammingdistance(a: List<Int>): Int {
    var t = 0
    for (i in 0 .. a.size - 2) {
        for (j in i + 1 .. a.size - 1) {
            t += popcount64(a[i] xor a[j])
        }
    }
    return t
}

fun main() {

    if (hammingdistance(listOf(4, 14, 2)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (hammingdistance(listOf(4, 14, 4)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
