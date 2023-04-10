fun toeplitzmatrix(a: List<List<Int>>): Boolean {
    val ym = a.size - 1
    val xm = a[0].size - 1
    var toeplitz = true
    for (xb in 1 - xm .. ym - 1) {
        var init = true
        var tv = 0
        for (x in xb .. xb + xm) {
            if (x >= 0 && x <= xm) {
                val y = x - xb
                if (y >= 0 && y <= ym) {
                    if (init) {
                        init = false
                        tv = a[y][x]
                    } else if (a[y][x] != tv) {
                        toeplitz = false
                        break
                    }
                }
            }
        }
        if (!toeplitz) {
            break
        }
    }
    return toeplitz
}

fun main() {

    if (toeplitzmatrix(listOf(listOf(4, 3, 2, 1), listOf(5, 4, 3, 2), listOf(6, 5, 4, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!toeplitzmatrix(listOf(listOf(1, 2, 3), listOf(3, 2, 1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
