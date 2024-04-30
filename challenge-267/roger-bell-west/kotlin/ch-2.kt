fun linecounts (a: String, w: List<Int>): List<Int> {
    var linecount = 1
    var linewidth = 0
    val asize = 'a'.code
    for (c in a.toList()) {
        val wd = w[c.code - asize]
        if (linewidth + wd > 100) {
            linecount += 1
            linewidth = wd
        } else {
            linewidth += wd
        }
    }
    return listOf(linecount, linewidth)
}

fun main() {

    if (linecounts("abcdefghijklmnopqrstuvwxyz", listOf(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)) == listOf(3, 60)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (linecounts("bbbcccdddaaa", listOf(4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)) == listOf(2, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
