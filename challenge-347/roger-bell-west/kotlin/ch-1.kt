fun formatdate(a: String): String {
    val re = "^([0-9]+)[a-z]+ ([A-Z][a-z]{2}) ([0-9]+)".toRegex()
    val mr = re.find(a)
    val d = mr!!.groupValues[1].toInt()
    val mt = mr.groupValues[2]
    val m = hashMapOf(
        "Jan" to 1,
        "Feb" to 2,
        "Mar" to 3,
        "Apr" to 4,
        "May" to 5,
        "Jun" to 6,
        "Jul" to 7,
        "Aug" to 8,
        "Sep" to 9,
        "Oct" to 10,
        "Nov" to 11,
        "Dec" to 12,
       ).getValue(mt)
    val y = mr.groupValues[3].toInt()
    return "%04d-%02d-%02d".format(y, m, d)
}

fun main() {

    if (formatdate("1st Jan 2025") == "2025-01-01") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatdate("22nd Feb 2025") == "2025-02-22") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatdate("15th Apr 2025") == "2025-04-15") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatdate("23rd Oct 2025") == "2025-10-23") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatdate("31st Dec 2025") == "2025-12-31") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
