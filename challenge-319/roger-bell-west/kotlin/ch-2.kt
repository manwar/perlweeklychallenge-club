fun minimumcommon(a: List<Int>, b: List<Int>): Int {
    val aa = a.toSet()
    val bb = b.toSet()
    val cc = aa.intersect(bb).toList()
    if (cc.size == 0) {
        return -1
    } else {
        return cc.minOrNull()!!
    }
}

fun main() {

    if (minimumcommon(listOf(1, 2, 3, 4), listOf(3, 4, 5, 6)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minimumcommon(listOf(1, 2, 3), listOf(2, 4)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minimumcommon(listOf(1, 2, 3, 4), listOf(5, 6, 7, 8)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
