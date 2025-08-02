fun targetindex(a0: List<Int>, k: Int): List<Int> {
    var a = ArrayList(a0).sorted()
    var r = ArrayList<Int>()
    a.forEachIndexed{i, v ->
                         if (v == k) {
                             r += i
                         }
    }
    return r.toList()
}

fun main() {

    if (targetindex(listOf(1, 5, 3, 2, 4, 2), 2) == listOf(1, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (targetindex(listOf(1, 2, 4, 3, 5), 6) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (targetindex(listOf(5, 3, 2, 4, 2, 1), 4) == listOf(4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
