fun luckynumbers (a: List<List<Int>>): Int {
    var maxs = mutableSetOf<List<Int>>()
    for (x in 0 .. a[0].size - 1) {
        var max = listOf(0, 0, 0)
        for (y in 0 .. a.size - 1) {
            if (a[y][x] > max[0]) {
                max = listOf(a[y][x], y, x)
            }
        }
        maxs.add(max)
    }
    var mins = mutableSetOf<List<Int>>()
    for (y in 0 .. a.size - 1) {
        var min = listOf(a[y][0], y, 0)
        for (x in 0 .. a[0].size - 1) {
            if (a[y][x] < min[0]) {
                min = listOf(a[y][x], y, x)
            }
        }
        mins.add(min)
    }
    val i = ArrayList(maxs.intersect(mins))
    if (i.size > 0) {
        return i[0][0]
    }
    return -1
}

fun main() {

    if (luckynumbers(listOf(listOf(3, 7, 9), listOf(9, 11, 13), listOf(15, 16, 17))) == 15) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (luckynumbers(listOf(listOf(1, 10, 4, 2), listOf(9, 3, 8, 7), listOf(15, 16, 17, 12))) == 12) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (luckynumbers(listOf(listOf(7, 8), listOf(1, 2))) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
