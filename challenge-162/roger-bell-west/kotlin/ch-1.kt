fun generate(in0: String): Int {
    val re = "[^0-9]+".toRegex()
    var in1 = re.replace(in0,"")
    if (in1.length < 12) {
        return 99
    }
    in1 = in1.substring(0..11)
    var s = 0
    var m = 1
    for (i in in1.toCharArray().toList()) {
        s += m * i.digitToInt()
        m = 4 - m
    }
    return (10-(s % 10)) % 10
}

fun validate(in0: String): Boolean {
    val re = "[^0-9]+".toRegex()
    var in1 = re.replace(in0,"")
    if (in1.length != 13) {
        return false
    }
    return generate(in1) == in1.get(12).digitToInt()
}

fun main() {
    if (generate("978-0-306-40615-") == 7) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (generate("978-0-306-40615-7") == 7) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (validate("978-0-306-40615-7") == true) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (validate("978-0-306-46015-7") == false) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
