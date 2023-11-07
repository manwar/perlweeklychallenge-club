fun flipmatrix(a: List<List<Int>>): List<List<Int>> {
    return a.map{row -> row.map{1 - it}.reversed()}
}

fun main() {

    if (flipmatrix(listOf(listOf(1, 1, 0), listOf(1, 0, 1), listOf(0, 0, 0))) == listOf(listOf(1, 0, 0), listOf(0, 1, 0), listOf(1, 1, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (flipmatrix(listOf(listOf(1, 1, 0, 0), listOf(1, 0, 0, 1), listOf(0, 1, 1, 1), listOf(1, 0, 1, 0))) == listOf(listOf(1, 1, 0, 0), listOf(0, 1, 1, 0), listOf(0, 0, 0, 1), listOf(1, 0, 1, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
