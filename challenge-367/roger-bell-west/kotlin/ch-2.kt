fun parsetime(t: String): Int {
    val p = t.split(':')
    return p[0].toInt() * 60 + p[1].toInt()
}

fun conflictevents(a: List<String>, b: List<String>): Boolean {
    var r = ArrayList<List<List<Int>>>()
    for (t in listOf(a, b)) {
        val st = parsetime(t[0])
        val en = parsetime(t[1])
        if (st < en) {
            r.add(listOf(listOf(st, en - 1)))
        } else {
            r.add(listOf(
                      listOf( st, 1440 - 1 ),
                      listOf( 0, en - 1 )
            ))
        }
    }
    for (ra in r[0]) {
        for (rb in r[1]) {
            if (ra[0] <= rb[1] && rb[0] <= ra[1]) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (conflictevents(listOf("10:00", "12:00"), listOf("11:00", "13:00"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!conflictevents(listOf("09:00", "10:30"), listOf("10:30", "12:00"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (conflictevents(listOf("14:00", "15:30"), listOf("14:30", "16:00"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!conflictevents(listOf("08:00", "09:00"), listOf("09:01", "10:00"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (conflictevents(listOf("23:30", "00:30"), listOf("00:00", "01:00"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
