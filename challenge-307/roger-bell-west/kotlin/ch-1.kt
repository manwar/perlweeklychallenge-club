fun checkorder(a: List<Int>): List<Int> {
    var b = a.sorted()
    var out = ArrayList<Int>()
    a.forEachIndexed{i, c ->
                         if (b[i] != c) {
                             out.add(i)
                         }
    }
    return out.toList()
}

fun main() {

    if (checkorder(listOf(5, 2, 4, 3, 1)) == listOf(0, 2, 3, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (checkorder(listOf(1, 2, 1, 1, 3)) == listOf(1, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (checkorder(listOf(3, 1, 3, 2, 3)) == listOf(0, 1, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
