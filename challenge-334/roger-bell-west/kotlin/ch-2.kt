fun nearestvalidpoint(x: Int, y: Int, points: List<List<Int>>): Int {
    var ix = -1
    var minmhd = -1
    points.forEachIndexed {i, p ->
                               if (p[0] == x || p[1] == y) {
                                   val mhd = Math.abs(p[0] - x) + Math.abs(p[1] - y)
                                   if (minmhd == -1 || mhd < minmhd) {
                                       minmhd = mhd
                                       ix = i
                                   }
                               }
    }
    return ix
}

fun main() {

    if (nearestvalidpoint(3, 4, listOf(listOf(1, 2), listOf(3, 1), listOf(2, 4), listOf(2, 3))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(2, 5, listOf(listOf(3, 4), listOf(2, 3), listOf(1, 5), listOf(2, 5))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(1, 1, listOf(listOf(2, 2), listOf(3, 3), listOf(4, 4))) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(0, 0, listOf(listOf(0, 1), listOf(1, 0), listOf(0, 2), listOf(2, 0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nearestvalidpoint(5, 5, listOf(listOf(5, 6), listOf(6, 5), listOf(5, 4), listOf(4, 5))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
