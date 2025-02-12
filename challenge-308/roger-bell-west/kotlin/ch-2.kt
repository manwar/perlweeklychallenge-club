fun decodexor(a: List<Int>, nit: Int): List<Int> {
    var out = ArrayList(listOf(nit))
    for (v in a) {
        out.add(out[out.size - 1] xor v)
    }
    return out.toList()
}

fun main() {

    if (decodexor(listOf(1, 2, 3), 1) == listOf(1, 0, 2, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (decodexor(listOf(6, 2, 7, 3), 4) == listOf(4, 2, 0, 7, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
