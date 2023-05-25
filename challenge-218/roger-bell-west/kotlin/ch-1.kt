fun maximumproduct(lst: List<Int>): Int {
    var l = ArrayList(lst)
    l.sort()
    val b = l.size
    var t = ArrayList<Int>()
    for (i in 0..3) {
        var p = 1
        if (i > 0) {
            for (j in 0 .. i-1) {
                p *= l[j]
            }
        }
        if (i < 3) {
            for (j in b - 3 + i .. b-1) {
                p *= l[j]
            }
        }
        t.add(p)
    }
    return t.maxOrNull()!!
}

fun main() {

    if (maximumproduct(listOf(3, 1, 2)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumproduct(listOf(4, 1, 3, 2)) == 24) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumproduct(listOf(-1, 0, 1, 3, 1)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumproduct(listOf(-8, 2, -9, 0, -4, 3)) == 216) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
