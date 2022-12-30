fun movezero(l: List<Int>): List<Int> {
    var o = ArrayList(l.filter { it != 0 })
    o.addAll(Array(l.size - o.size) {_ -> 0})
    return o.toList()
}

fun main() {
    if (movezero(listOf(1, 0, 3, 0, 0, 5)) == listOf(1, 3, 5, 0, 0, 0)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (movezero(listOf(1, 6, 4)) == listOf(1, 6, 4)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (movezero(listOf(0, 1, 0, 2, 0)) == listOf(1, 2, 0, 0, 0)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
