fun separatedigits(a: List<Int>): List<Int> {
    var out = ArrayList<Int>()
    for (n in a) {
        var m = n
        var v = ArrayList<Int>()
        while (m > 0) {
            v.add(m % 10)
            m /= 10
        }
        out.addAll(v.reversed())
    }
    return out.toList()
}

fun main() {

    if (separatedigits(listOf(1, 34, 5, 6)) == listOf(1, 3, 4, 5, 6)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (separatedigits(listOf(1, 24, 51, 60)) == listOf(1, 2, 4, 5, 1, 6, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
