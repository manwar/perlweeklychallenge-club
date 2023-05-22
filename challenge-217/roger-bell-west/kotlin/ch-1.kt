fun sortedmatrix(matrix: List<List<Int>>): Int {
    var n = ArrayList(matrix.flatten())
    n.sort()
    return n[2]
}

fun main() {

    if (sortedmatrix(listOf(listOf(3, 1, 2), listOf(5, 2, 4), listOf(0, 1, 3))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortedmatrix(listOf(listOf(2, 1), listOf(4, 5))) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortedmatrix(listOf(listOf(1, 0, 3), listOf(0, 0, 0), listOf(1, 2, 1))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
