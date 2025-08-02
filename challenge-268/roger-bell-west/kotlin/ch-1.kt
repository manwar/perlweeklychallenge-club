fun magicnumber(a: List<Int>, b: List<Int>): Int {
    return b.minOrNull()!! - a.minOrNull()!!
}

fun main() {

    if (magicnumber(listOf(3, 7, 5), listOf(9, 5, 7)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (magicnumber(listOf(1, 2, 1), listOf(5, 4, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (magicnumber(listOf(2), listOf(5)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
