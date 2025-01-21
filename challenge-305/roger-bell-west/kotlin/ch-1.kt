fun isqrt(s: Int): Int {
    if (s <= 1) {
        return s
    } else {
        var x0 = s / 2
        var x1 = (x0 + s / x0) / 2
        while (x1 < x0) {
            x0 = x1
            x1 = (x0 + s / x0) / 2
        }
        return x0
    }
}

fun is_prime(candidate: Int): Boolean {
    if (candidate < 2) {
        return false
    } else if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    var anchor=0
    val limit = isqrt(candidate)
    while (true) {
        anchor += 6
        for (t in anchor-1..anchor+1 step 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0) {
                return false
            }
        }
    }
}

fun binaryprefix(a: List<Int>): List<Boolean> {
    var out =  ArrayList<Boolean>()
    var n = 0
    for (x in a) {
        n *= 2
        if (x == 1) {
            n += 1
        }
        out.add(is_prime(n))
    }
    return out.toList()
}

fun main() {

    if (binaryprefix(listOf(1, 0, 1)) == listOf(false, true, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(1, 1, 0)) == listOf(false, true, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)) == listOf(false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
