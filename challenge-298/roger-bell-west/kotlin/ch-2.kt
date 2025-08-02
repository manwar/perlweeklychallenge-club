fun rightinterval(a: List<List<Int>>): List<Int> {
    val ss = a.map{it[0]}
    var si = ArrayList((0 .. a.size - 1).toList())
    si.sortWith(compareBy { ss[it] })
    var out = ArrayList<Int>()
    for (l in a) {
        val ix = si.filter{ ss[it] >= l[1] }.toList()
        if (ix.size == 0) {
            out.add(-1)
        } else {
            out.add(ix[0])
        }
    }
    return out.toList()
}

fun main() {

    if (rightinterval(listOf(listOf(3, 4), listOf(2, 3), listOf(1, 2))) == listOf(-1, 0, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rightinterval(listOf(listOf(1, 4), listOf(2, 3), listOf(3, 4))) == listOf(-1, 2, -1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rightinterval(listOf(listOf(1, 2))) == listOf(-1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rightinterval(listOf(listOf(1, 4), listOf(2, 2), listOf(3, 4))) == listOf(-1, 1, -1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
