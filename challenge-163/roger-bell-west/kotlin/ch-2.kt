fun summation(ls0: List<Int>): Int {
    var ls = ArrayList(ls0)
    while (ls.size > 1) {
        var lv = ArrayList<Int>()
        for (i in 1..ls.size-1) {
            lv.add((1..i).map {ls[it]}.reduce {sum,n -> sum + n})
        }
        ls = lv
    }
    return ls[0]
}

fun main() {
    if (summation(listOf(1,2,3,4,5)) == 42) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (summation(listOf(1,3,5,7,9)) == 70) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
