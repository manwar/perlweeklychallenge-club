fun dyckwords(order: Int): List<String> {
    var out = ArrayList<String>()
    var queue = ArrayDeque<String>()
    queue.add("")
    while (queue.size > 0) {
        val st = queue.removeAt(0)
        val dcount = st.toList().filter{it == 'D'}.size
        if (st.length == order * 2) {
            if (dcount == order) {
                out.add(st)
            }
        } else {
            if (dcount * 2 < st.length) {
                queue.add(st + "D")
            }
            queue.add(st + "U")
        }
    }
    return out.toList()
}

fun main() {

    if (dyckwords(1) == listOf("UD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dyckwords(2) == listOf("UDUD", "UUDD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dyckwords(3) == listOf("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dyckwords(0) == listOf("")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dyckwords(4) == listOf("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
