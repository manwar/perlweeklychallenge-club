fun matrixscore(matrix0: List<List<Int>>): Int {
    var matrix = ArrayList<ArrayList<Int>>()
    for (r in matrix0) {
        matrix.add(ArrayList(r))
    }
    for (i in 0 .. matrix.size-1) {
        if (matrix[i][0] == 0) {
            for (j in 0 .. matrix[i].size-1) {
                matrix[i][j] = 1 - matrix[i][j]
            }
        }
    }
    val t = matrix.size / 2
    for (i in 1 .. matrix[0].size-1) {
        var c = 0
        for (j in 0 .. matrix.size-1) {
            if (matrix[j][i] == 0) {
                c += 1
            }
        }
        if (c > t) {
            for (j in 0 .. matrix.size-1) {
                matrix[j][i] = 1 - matrix[j][i]
            }
        }
    }
    var tot = 0
    for (m in matrix) {
        var p = 0
        for (n in m) {
            p *= 2
            if (n == 1) {
                p += 1
            }
        }
        tot += p
    }
    return tot
}

fun main() {

    if (matrixscore(listOf(listOf(0, 0, 1, 1), listOf(1, 0, 1, 0), listOf(1, 1, 1, 0))) == 39) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matrixscore(listOf(listOf(0))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
