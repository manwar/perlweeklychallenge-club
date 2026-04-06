fun maxoddbinary(a: String): String {
    var ones = 0
    var zeroes = 0
    for (c in a) {
        if (c == '0') {
            zeroes += 1
        } else if (c == '1') {
            ones += 1
        }
    }
    if (ones < 1) {
        return ""
    }
    var out = ""
    for (i in 2 .. ones) {
        out += "1"
    }
    for (i in 1 .. zeroes) {
        out += "0"
    }
    out += "1"
    return out
}

fun main() {

    if (maxoddbinary("1011") == "1101") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxoddbinary("100") == "001") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxoddbinary("111000") == "110001") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxoddbinary("0101") == "1001") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxoddbinary("1111") == "1111") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
