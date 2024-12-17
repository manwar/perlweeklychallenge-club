fun nestedarray(a: List<Int>): Int {
    var arr = 0
    for (i in 0 .. a.size - 1) {
        var trail = ArrayList<Int>()
        var j = i
        while (true) {
            j = a[j]
            if (trail.contains(j)) {
                break
            }
            trail.add(j)
        }
        arr = listOf(arr, trail.size).maxOrNull()!!
    }
    return arr
}

fun main() {

    if (nestedarray(listOf(5, 4, 0, 3, 1, 6, 2)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nestedarray(listOf(0, 1, 2)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
