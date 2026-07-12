fun smallergreaterelement(a: List<Int>): Int {
    val mn = a.minOrNull()!!
    val mx = a.maxOrNull()!!
    return a.filter {it != mn && it != mx}.size
}

fun main() {

    if (smallergreaterelement(listOf(2, 4)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallergreaterelement(listOf(1, 1, 1, 1)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallergreaterelement(listOf(1, 1, 4, 8, 12, 12)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallergreaterelement(listOf(3, 6, 6, 9)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallergreaterelement(listOf(0, -5, 10, -2, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
