import kotlin.math.*

fun esthetic10(n: Int): Boolean {
    return esthetic(n, 10)
}

fun esthetic(n0: Int, base: Int): Boolean {
    var n = n0
    var pdigit = 0
    var ch = false
    while (n > 0) {
        var digit = n % base
        if (ch && abs(digit - pdigit) != 1) {
            return false
        }
        ch = true
        pdigit = digit
        n /= base
    }
    return true
}

fun main() {
    if (esthetic10(5456)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (!esthetic10(120)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (esthetic10(12)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (esthetic10(5654)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (!esthetic10(890)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    println("")
}
