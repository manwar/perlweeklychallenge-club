fun sumbitwise(ls: List<Int>): Int {
    var s = 0
    for (i in 0..ls.size-2) {
        for (j in i+1..ls.size-1) {
            s += ls[i] and ls[j]
        }
    }
    return s
}

fun main() {
    if (sumbitwise(listOf(1,2,3)) == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (sumbitwise(listOf(2,3,4)) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
