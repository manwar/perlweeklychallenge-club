fun maximalsquare(a: List<List<Int>>): Int {
    var mx = 0
    val boundy = a.size
    val boundx = a[0].size
    for (y in 0 .. boundy - 1) {
        for (x in 0 .. boundx - 1) {
            var size = 0
            while (true) {
                var tests = ArrayList<List<Int>>()
                for (xx in x .. x + size) {
                    tests.add(listOf(y + size, xx))
                }
                if (size > 0) {
                    for (yy in y .. y + size - 1) {
                        tests.add(listOf(yy, x + size))
                    }
                }
                if (tests.map {a[it[0]][it[1]]}.any{it == 0}) {
                    break
                }
                size += 1
                if (x + size >= boundx || y + size >= boundy) {
                    break
                }
            }
            mx = listOf(mx, size * size).maxOrNull()!!
        }
    }
    return mx
}

fun main() {

    if (maximalsquare(listOf(listOf(1, 0, 1, 0, 0), listOf(1, 0, 1, 1, 1), listOf(1, 1, 1, 1, 1), listOf(1, 0, 0, 1, 0))) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximalsquare(listOf(listOf(0, 1), listOf(1, 0))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximalsquare(listOf(listOf(0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
