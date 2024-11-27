fun twicelargest(a: List<Int>): Int {
    val p = a.sorted().reversed()
    var ret = -1
    if (p[0] >= 2 * p[1]) {
        a.forEachIndexed{i, c ->
                             if (c == p[0] && ret == -1) {
                                 ret = i
                             }
        }
    }
    return ret
}

fun main() {

    if (twicelargest(listOf(2, 4, 1, 0)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (twicelargest(listOf(1, 2, 3, 4)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
