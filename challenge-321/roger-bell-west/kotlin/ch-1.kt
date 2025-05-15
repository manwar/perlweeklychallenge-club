fun distinctaverage(a0: List<Int>): Int {
    val a = a0.sorted()
    val offset = a.size - 1
    val limit = a.size / 2
    var res = mutableSetOf<Int>()
    for (i in 0 .. limit - 1) {
        res.add(a[i] + a[offset - i])
    }
    return res.size
}

fun main() {

    if (distinctaverage(listOf(1, 2, 4, 3, 5, 6)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distinctaverage(listOf(0, 2, 4, 8, 3, 5)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distinctaverage(listOf(7, 3, 1, 0, 5, 9)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
