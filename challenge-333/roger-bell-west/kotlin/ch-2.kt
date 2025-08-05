fun duplicatezeros(a: List<Int>): List<Int> {
    var b = ArrayList<Int>()
    for (n in a) {
        b.add(n)
        if (a.size == b.size) {
            break
        }
        if (n == 0) {
            b.add(0)
            if (a.size == b.size) {
                break
            }
        }
    }
    return b.toList()
}

fun main() {

    if (duplicatezeros(listOf(1, 0, 2, 3, 0, 4, 5, 0)) == listOf(1, 0, 0, 2, 3, 0, 0, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicatezeros(listOf(1, 2, 3)) == listOf(1, 2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicatezeros(listOf(1, 2, 3, 0)) == listOf(1, 2, 3, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicatezeros(listOf(0, 0, 1, 2)) == listOf(0, 0, 0, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicatezeros(listOf(1, 2, 0, 3, 4)) == listOf(1, 2, 0, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
