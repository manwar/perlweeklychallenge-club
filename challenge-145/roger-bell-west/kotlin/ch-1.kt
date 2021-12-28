fun dotproduct(a: List<Int>,b: List<Int>): Int {
    var p: Int=0
    for ((i,v) in a.withIndex()) {
        p += v * b[i]
    }
    return p
}

fun main() {
    if (dotproduct(listOf<Int>(1,2,3),listOf<Int>(4,5,6)) == 32) {
        println("Pass")
    } else {
        println("FAIL")
    }
}
