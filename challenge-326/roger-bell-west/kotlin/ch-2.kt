fun decompressedlist(a: List<Int>): List<Int> {
    var out = ArrayList<Int>()
    for (i in a.chunked(2)) {
        for (n in 1 .. i[0]) {
            out.add(i[1])
        }
    }
    return out.toList()
}

fun main() {

    if (decompressedlist(listOf(1, 3, 2, 4)) == listOf(3, 4, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (decompressedlist(listOf(1, 1, 2, 2)) == listOf(1, 2, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (decompressedlist(listOf(3, 1, 3, 2)) == listOf(1, 1, 1, 2, 2, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
