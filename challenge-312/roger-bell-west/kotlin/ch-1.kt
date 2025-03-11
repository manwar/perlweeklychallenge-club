import kotlin.math.min

fun transfer(a: Char, b: Char): Int {
    val ac = a.code
    val bc = b.code
    return min((ac - bc + 26) % 26, (bc - ac + 26) % 26)
}

fun minimumtime(a: String): Int {
    var tot = a.length
    var prev = 'a'
    for (c in a.toCharArray()) {
        tot += transfer(prev, c)
        prev = c
    }
    return tot
}

fun main() {

    if (minimumtime("abc") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minimumtime("bza") == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minimumtime("zjpc") == 34) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
