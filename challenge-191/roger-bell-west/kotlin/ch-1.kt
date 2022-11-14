fun twicelargest(l0: List<Int>): Boolean {
    var l = ArrayList(l0)
    l.sort()
    return l.last() >= 2*l[l.size - 2]
}

fun main() {
    if (!twicelargest(listOf(1, 2, 3, 4))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (twicelargest(listOf(1, 2, 0, 5))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (twicelargest(listOf(2, 6, 3, 1))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (!twicelargest(listOf(4, 5, 2, 3))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
