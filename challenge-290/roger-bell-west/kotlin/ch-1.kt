fun doubleexist(a: List<Int>): Boolean {
    for (i in 0 .. a.size - 2) {
        for (j in (i + 1) .. a.size - 1) {
            if (a[i] == 2 * a[j] || a[j] == 2 * a[i]) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (doubleexist(listOf(6, 2, 3, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!doubleexist(listOf(3, 1, 4, 13))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (doubleexist(listOf(2, 1, 4, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
