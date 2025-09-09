fun highestrow(a: List<List<Int>>): Int {
    return a.map{ it.sum() }.maxOrNull()!!
}

fun main() {

    if (highestrow(listOf(listOf(4, 4, 4, 4), listOf(10, 0, 0, 0), listOf(2, 2, 2, 9))) == 16) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (highestrow(listOf(listOf(1, 5), listOf(7, 3), listOf(3, 5))) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (highestrow(listOf(listOf(1, 2, 3), listOf(3, 2, 1))) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (highestrow(listOf(listOf(2, 8, 7), listOf(7, 1, 3), listOf(1, 9, 5))) == 17) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (highestrow(listOf(listOf(10, 20, 30), listOf(5, 5, 5), listOf(0, 100, 0), listOf(25, 25, 25))) == 100) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
