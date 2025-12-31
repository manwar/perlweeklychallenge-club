fun shiftgrid(gi: List<List<Int>>, k0: Int): List<List<Int>> {
    val wi = gi.flatten()
    val k = k0 % wi.size
    val wo = wi.drop(wi.size - k) + wi.slice(0 .. wi.size - k - 1)
    return wo.chunked(gi[0].size)
}

fun main() {

    if (shiftgrid(listOf(listOf(1, 2, 3), listOf(4, 5, 6), listOf(7, 8, 9)), 1) == listOf(listOf(9, 1, 2), listOf(3, 4, 5), listOf(6, 7, 8))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shiftgrid(listOf(listOf(10, 20), listOf(30, 40)), 1) == listOf(listOf(40, 10), listOf(20, 30))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shiftgrid(listOf(listOf(1, 2), listOf(3, 4), listOf(5, 6)), 1) == listOf(listOf(6, 1), listOf(2, 3), listOf(4, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shiftgrid(listOf(listOf(1, 2, 3), listOf(4, 5, 6)), 5) == listOf(listOf(2, 3, 4), listOf(5, 6, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shiftgrid(listOf(listOf(1, 2, 3, 4)), 1) == listOf(listOf(4, 1, 2, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
