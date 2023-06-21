fun lastmember(a0: List<Int>): Int {
    var a = ArrayList(a0)
    while (a.size > 1) {
        a.sort()
        val x = a.removeLast()
        val y = a.removeLast()
        if (x != y) {
            a.add(x - y)
        }
    }
    if (a.size == 0) {
        return 0
    } else {
        return a[0]
    }
}
    
fun main() {

    if (lastmember(listOf(2, 7, 4, 1, 8, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lastmember(listOf(1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lastmember(listOf(1, 1)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
