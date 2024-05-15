fun bitwiseor(a: List<Int>): Boolean {
    return a.filter {it % 2 == 0}.size >= 2
}

fun main() {

    if (bitwiseor(listOf(1, 2, 3, 4, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (bitwiseor(listOf(2, 3, 8, 16))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!bitwiseor(listOf(1, 2, 5, 7, 9))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
