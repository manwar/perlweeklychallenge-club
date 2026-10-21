fun finishingorder(order: List<Int>, friends: List<Int>): List<Int> {
    return order.filter{friends.contains(it)}
}

fun main() {

    if (finishingorder(listOf(3, 1, 4, 2, 5), listOf(1, 4, 2)) == listOf(1, 4, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finishingorder(listOf(5, 4, 3, 2, 1), listOf(1, 3, 5)) == listOf(5, 3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finishingorder(listOf(2, 4, 1, 3), listOf(1, 2, 3, 4)) == listOf(2, 4, 1, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finishingorder(listOf(4, 1, 3, 2), listOf(3)) == listOf(3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finishingorder(listOf(1, 3, 2, 6, 5, 4), listOf(1, 2, 3)) == listOf(1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
