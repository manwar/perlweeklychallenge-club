fun arrayloops(a: List<Int>): Int {
    var loop_id = 0
    var loops = mutableMapOf<Int, Int>()
    for (origin in 0..a.size-1) {
        if (!loops.contains(origin)) {
            var li = 0
            var thisloop = mutableSetOf<Int>()
            var x = origin
            while (true) {
                if (x >= a.size) {
                    break
                }
                thisloop.add(x)
                x = a[x]
                if (loops.contains(x)) {
                    li = loops.getValue(x)
                    break
                }
                if (thisloop.contains(x)) {
                    loop_id += 1
                    li = loop_id
                    break
                }
            }
            for (i in thisloop) {
                loops.put(i, li)
            }
        }
    }
    return loop_id
}

fun main() {

    if (arrayloops(listOf(4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrayloops(listOf(0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrayloops(listOf(9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
