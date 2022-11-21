fun binaryflip(n: Int): Int {
    var m = n
    var r = 0
    while (m > 0) {
        m = m shr 1
        r += 1
    }
    return (1 shl r) - 1 - n
}

fun main() {
    if (binaryflip(5) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (binaryflip(4) == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (binaryflip(6) == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
