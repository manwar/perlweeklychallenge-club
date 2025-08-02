fun distributeelements(a: List<Int>): List<Int> {
    var x = ArrayList<Int>(listOf(a[0]))
    var y = ArrayList<Int>(listOf(a[1]))
    a.drop(2).forEach { n -> run {
                            if (x.last() > y.last()) {
                                x.add(n)
                            } else {
                                y.add(n)
                            }
                        }
    }
    y.toCollection(x)
    return x.toList()
}

fun main() {

    if (distributeelements(listOf(2, 1, 3, 4, 5)) == listOf(2, 3, 4, 5, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distributeelements(listOf(3, 2, 4)) == listOf(3, 4, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distributeelements(listOf(5, 4, 3, 8)) == listOf(5, 3, 4, 8)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
