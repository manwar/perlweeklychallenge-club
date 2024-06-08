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

fun sortbyonebits(a: List<Int>): List<Int> {
    var b = ArrayList(a)
    var c = mutableMapOf<Int, Int>()
    for (v in a.toSet()) {
        c[v] = popcount64(v);
    }
    b.sort()
    b.sortBy { c[it] }
    return b.toList()
}

fun main() {

    if (sortbyonebits(listOf(0, 1, 2, 3, 4, 5, 6, 7, 8)) == listOf(0, 1, 2, 4, 8, 3, 5, 6, 7)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortbyonebits(listOf(1024, 512, 256, 128, 64)) == listOf(64, 128, 256, 512, 1024)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
