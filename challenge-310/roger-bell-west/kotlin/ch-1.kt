fun arraysintersection(a: List<List<Int>>): List<Int> {
    var s = a[0].toMutableSet()
    for (b in a.drop(1)) {
        s = s.toSet().intersect(b.toSet()).toMutableSet()
    }
    var o = ArrayList(s)
    o.sort()
    return o
}

fun main() {

    if (arraysintersection(listOf(listOf(1, 2, 3, 4), listOf(4, 5, 6, 1), listOf(4, 2, 1, 3))) == listOf(1, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraysintersection(listOf(listOf(1, 0, 2, 3), listOf(2, 4, 5))) == listOf(2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arraysintersection(listOf(listOf(1, 2, 3), listOf(4, 5), listOf(6))) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
