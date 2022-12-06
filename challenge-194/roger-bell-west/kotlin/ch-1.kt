fun digitalclock(hhmm: String): Int {
    val i = hhmm.indexOf("?")
    if (i == 0) {
        if (hhmm[1] <= '3') {
            return 2;
        }
        return 1;
    } else if (i == 1) {
        if (hhmm[0] < '2') {
            return 9;
        }
        return 3;
    } else if (i == 3) {
        return 5;
    } else if (i == 4) {
        return 9;
    }
    return 0;
}

fun main() {
    if (digitalclock("?5:00") == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (digitalclock("?3:00") == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (digitalclock("1?:00") == 9) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (digitalclock("2?:00") == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (digitalclock("12:?5") == 5) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (digitalclock("12:5?") == 9) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
