fun duplicatezeros(a: List<Int>): List<Int> {
    var out = ArrayList<Int>()
    for (t in a) {
        out.add(t)
        if (t == 0) {
            out.add(t)
        }
        if (out.size >= a.size) {
            break
        }
    }
    if (out.size > a.size) {
        out = ArrayList(out.dropLast(out.size - a.size))
    }
    return out.toList()
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
    if (duplicatezeros(listOf(0, 3, 0, 4, 5)) == listOf(0, 0, 3, 0, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
