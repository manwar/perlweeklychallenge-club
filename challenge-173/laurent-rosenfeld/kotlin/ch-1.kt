import kotlin.math.abs

fun is_esthetic(num: Int): Boolean {
    val n = num.toString()
    for (i in 1..n.length - 1) {
        if (abs(n[i] - n[i-1]) != 1) {
            return false
        }
    }
    return true
}
fun main() {
    for (test in arrayOf(5456, 120, 121, 23456, 2346, 7654567, 765467)) {
        if (is_esthetic(test)) {
            println("$test is esthetic")
        } else {
            println("$test is not esthetic")
        }
    }
}
