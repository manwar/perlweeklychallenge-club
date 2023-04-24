fun funsort(l0: List<Int>): List<Int> {
    var l = ArrayList(l0)
    l.sort()
    var a = ArrayList<Int>()
    var b = ArrayList<Int>()
    for (k in l) {
        if (k % 2 == 0) {
            a.add(k)
        } else {
            b.add(k)
        }
    }
    a.addAll(b)
    return a.toList()
}

fun main() {

    if (funsort(listOf(1, 2, 3, 4, 5, 6)) == listOf(2, 4, 6, 1, 3, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (funsort(listOf(1, 2)) == listOf(2, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (funsort(listOf(1)) == listOf(1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
