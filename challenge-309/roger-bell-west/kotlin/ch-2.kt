fun mindiff(a: List<Int>): Int {
    var md = 0
    var n = false
    for (i in 0 .. a.size - 2) {
        for (j in i + 1 .. a.size - 1) {
            val diff = Math.abs(a[i] - a[j])
            if (!n || diff < md) {
                md = diff
                n = true
            }
        }
    }
    return md
}

fun main() {

    if (mindiff(listOf(1, 5, 8, 9)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mindiff(listOf(9, 4, 1, 7)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
