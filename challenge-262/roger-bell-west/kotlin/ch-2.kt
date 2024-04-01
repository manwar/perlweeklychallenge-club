
fun countequaldivisible(a: List<Int>, k: Int): Int {
    var s = 0
    for (i in 0 .. a.size - 2) {
        for (j in i + 1 .. a.size - 1) {
            if (a[i] == a[j] && i * j % k == 0) {
                s += 1
            }
        }
    }
    return s
}

fun main() {

    if (countequaldivisible(listOf(3, 1, 2, 2, 2, 1, 3), 2) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countequaldivisible(listOf(1, 2, 3), 1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
