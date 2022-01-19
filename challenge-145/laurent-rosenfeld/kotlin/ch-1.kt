fun dot_product(a1: List<Int>, a2: List<Int>): Int {
    var res = 0
    for (i in a1.indices) {
        res += a1[i] * a2[i]
    }
    return res
}
fun main() {
    println (dot_product(listOf<Int>(1, 2, 3), listOf<Int>(4, 5, 6)))
}
