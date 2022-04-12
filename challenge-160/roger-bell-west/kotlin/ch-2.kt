import kotlin.math.*

fun equilibriumindex(s: List<Int>): Int {
    val sm = s.sum()
    var sa = 0
    for ((i,v) in s.withIndex()) {
        sa += v
        if (sa == sm) {
            return i
        }
        sa += v
    }
    return -1
}

fun main() {
    if (equilibriumindex(listOf(1,3,5,7,9)) == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (equilibriumindex(listOf(1,2,3,4,5)) == -1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (equilibriumindex(listOf(2,4,2)) == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
