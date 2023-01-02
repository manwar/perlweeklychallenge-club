fun maxgap(l0: List<Int>): Int {
    if (l0.size < 2) {
        return 0
    }
    var l = ArrayList(l0)
    l.sort()
    var q = ArrayList<Int>()
    for (i in l.windowed(size = 2)) {
        q.add(i[1] - i[0])
    }
    val mq = q.maxOrNull()!!
    return q.filter{it == mq}.size
}

fun main() {
    if (maxgap(listOf(2, 5, 8, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")

    if (maxgap(listOf(3)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")
}
