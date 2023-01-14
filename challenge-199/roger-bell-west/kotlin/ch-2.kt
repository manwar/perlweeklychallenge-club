import kotlin.math.*

fun goodtriplets(a: List<Int>, x: Int, y: Int, z: Int): Int {
    var c = 0
    for (i in 0..a.size-3) {
        for (j in i+1..a.size-2) {
            if (abs(a[i] - a[j]) <= x) {
                for (k in j+1..a.size-1) {
                    if (abs(a[j] - a[k]) <= y &&
                        abs(a[i] - a[k]) <= z) {
                        c += 1
                    }
                }
            }
        }
    }
    return c
}

fun main() {

    if (goodtriplets(listOf(3, 0, 1, 1, 9, 7), 7, 2, 3) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodtriplets(listOf(1, 1, 2, 2, 3), 0, 0, 1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
