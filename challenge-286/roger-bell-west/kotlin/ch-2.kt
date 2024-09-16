fun ordergame(a: List<Int>): Int {
    var p = ArrayList(a)
    while (p.size > 1) {
        var q = ArrayList<Int>()
        var mm = true
        for (j in p.windowed(2)) {
            if (mm) {
                q += listOf(j[0], j[1]).minOrNull()!!
            } else {
                q += listOf(j[0], j[1]).maxOrNull()!!
            }
            mm = !mm
        }
        p = q
    }
    return p[0]
}

fun main() {

    if (ordergame(listOf(2, 1, 4, 5, 6, 3, 0, 2)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ordergame(listOf(0, 5, 3, 2)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ordergame(listOf(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
