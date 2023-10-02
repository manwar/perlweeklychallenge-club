fun roman2int(roman: String): Int {
    if (roman == "") {
        return 0
    }
    for (s in listOf(
        Pair( "M", 1000 ),
        Pair( "CM", 900 ),
        Pair( "D", 500 ),
        Pair( "CD", 400 ),
        Pair( "C", 100 ),
        Pair( "XC", 90 ),
        Pair( "L", 50 ),
        Pair( "XL", 40 ),
        Pair( "X", 10 ),
        Pair( "IX", 9 ),
        Pair( "V", 5 ),
        Pair( "IV", 4 ),
        Pair( "I", 1 ),
    )) {
        if (roman.startsWith(s.first)) {
            return s.second + roman2int(roman.slice(s.first.length .. roman.length-1))
        }
    }
    return 0
}

fun int2roman(n0: Int): String {
    var number = n0
    var mn = ""
    for (s in listOf(
        Pair( "M", 1000 ),
        Pair( "CM", 900 ),
        Pair( "D", 500 ),
        Pair( "CD", 400 ),
        Pair( "C", 100 ),
        Pair( "XC", 90 ),
        Pair( "L", 50 ),
        Pair( "XL", 40 ),
        Pair( "X", 10 ),
        Pair( "IX", 9 ),
        Pair( "V", 5 ),
        Pair( "IV", 4 ),
        Pair( "I", 1 ),
    )) {
        while (s.second <= number) {
            mn += s.first
            number -= s.second
        }
    }
    return mn
}

fun intPow(x0: Int,pow0: Int): Int {
    var x=x0
    var pow=pow0
    var ret=1
    while (pow > 0) {
        if ( (pow and 1) == 1 ) {
            ret *= x
        }
        x *= x
        pow = pow shr 1
    }
    return ret
}

fun romanmaths(ax: String): String {
    val elems = ax.split(" ")
    val a = roman2int(elems[0])
    val b = roman2int(elems[2])
    var c = -1
    if (elems[1] == "+") {
        c = a + b
    } else if (elems[1] == "-") {
        c = a - b
    } else if (elems[1] == "*") {
        c = a * b
    } else if (elems[1] == "/") {
        if (a % b == 0) {
            c = a / b
        }
    } else if (elems[1] == "**") {
        c = intPow(a, b)
    }
    if (c > 3999 || c < 0) {
        return "non potest"
    } else if (c == 0) {
        return "nulla"
    } else {
        return int2roman(c)
    }
}

fun main() {

    if (roman2int("I") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (roman2int("II") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (roman2int("IV") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (roman2int("IX") == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (roman2int("XXX") == 30) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (roman2int("MDCLXVI") == 1666) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(1) == "I") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(2) == "II") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(4) == "IV") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(9) == "IX") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(30) == "XXX") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (int2roman(1666) == "MDCLXVI") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("IV + V") == "IX") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("M - I") == "CMXCIX") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("X / II") == "V") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("XI * VI") == "LXVI") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("VII ** III") == "CCCXLIII") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("V - V") == "nulla") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("V / II") == "non potest") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("MMM + M") == "non potest") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (romanmaths("V - X") == "non potest") {
        print("Pass")
    } else {
        print("Fail")
 }
    println("")

}
