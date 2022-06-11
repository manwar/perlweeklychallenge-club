import kotlin.math.*

fun brazilian(n: Int): Boolean {
    for (b in 2..n-2) {
        var nn=n
        var braz=true
        val digit = nn % b
        while (nn > 0) {
            if (digit == nn % b) {
                nn = (nn/b).toInt()
            } else {
                braz=false
                break
            }
        }
        if (braz) {
            return true
        }
    }
    return false
}

fun main() {
    if (brazilian(7)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (!brazilian(6)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (brazilian(8)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
