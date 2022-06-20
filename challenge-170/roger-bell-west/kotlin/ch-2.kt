fun kronecker(a: ArrayList<ArrayList<Int>>, b: ArrayList<ArrayList<Int>>): ArrayList<ArrayList<Int>> {
    var o = ArrayList<ArrayList<Int>>()
    val ax = a[0].size
    val ay = a.size
    val bx = b[0].size
    val bY = b.size
    for (y in 0..ay*bY - 1) {
        val byi = y % bY
        val ayi = y / bY
        var row = ArrayList<Int>()
        for (x in 0..ax*bx - 1) {
            val bxi = x % bx
            val axi = x / bx
            row.add(a[ayi][axi] * b[byi][bxi])
        }
        o.add(row)
    }
    return o
}

fun main() {
    if (kronecker(arrayListOf(arrayListOf(1,2),arrayListOf(3,4)),
                  arrayListOf(arrayListOf(5,6),arrayListOf(7,8))
        ) == arrayListOf(
            arrayListOf( 5,  6, 10, 12),
            arrayListOf( 7,  8, 14, 16),
            arrayListOf(15, 18, 20, 24),
            arrayListOf(21, 24, 28, 32)
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
