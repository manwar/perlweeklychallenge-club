fun leftrightsumdiff(a: List<Int>): List<Int> {
    val al = a.size - 1
    var left = ArrayList<Int>(listOf(0))
    var right = ArrayList<Int>(listOf(0))
    for (i in 0 .. al - 1) {
        left.add(left[i] + a[i])
        right.add(right[i] + a[al - i])
    }
    right.reverse()
    return left.zip(right).map{Math.abs(it.first - it.second)}.toList()
}

fun main() {

    if (leftrightsumdiff(listOf(10, 4, 8, 3)) == listOf(15, 1, 11, 22)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (leftrightsumdiff(listOf(1)) == listOf(0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (leftrightsumdiff(listOf(1, 2, 3, 4, 5)) == listOf(14, 11, 6, 1, 10)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
