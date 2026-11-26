fun lcm(m: Int,n: Int): Int {
    return m/gcd(m,n)*n
}

fun gcd(m0: Int,n0: Int): Int {
    var m=m0
    var n=n0
    while (n != 0) {
        val tmp=m % n
        m = n
        n = tmp
    }
    return m
}

class Rational(var n: Int = 1,var d: Int = 1) {
    fun stringify(): String {
        return "%d/%d".format(n,d)
    }

    fun add(other: Rational): Rational {
        var xd = lcm(d, other.d)
        var xn = n * xd / d + other.n * xd / other.d
        val dv = gcd(xn, xd)
        if (dv > 1) {
            xn /= dv
            xd /= dv
        }
        return Rational(xn, xd)
    }
}

fun fractionaladditionsubstraction(a: String): String {
    var terms = ArrayList<Rational>()
    var state = 0
    var n = 0
    var num = 0
    var sign = 0
    val cv = a.toList()
    var i = 0
    while (i < cv.size) {
        when(state) {
            0 -> {
                when(cv[i]) {
                    '+' -> {
                        state = 0
                        i += 1
                    }
                    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' -> {
                        sign = 1
                        state = 1
                        n = cv[i].digitToInt()
                        i += 1
                    }
                    '-' -> {
                        sign = -1
                        state = 1
                        n = 0
                        i += 1
                    }
                }
            }
            1 -> {
                when(cv[i]) {
                    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' -> {
                        n = n * 10 + cv[i].digitToInt()
                        i += 1
                    }
                    '/' -> {
                        num = n * sign
                        n = 0
                        state = 2
                        i += 1
                    }
                }
            }
            2 -> {
                when(cv[i]) {
                    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' -> {
                        n = n * 10 + cv[i].digitToInt()
                        i += 1
                    }
                    else -> {
                        terms.add(Rational(num, n))
                        state = 0
                    }
                }
            }
        }
    }
    if (state == 2) {
        terms.add(Rational(num, n))
    }
    var out = Rational(terms[0].n, terms[0].d)
    for (nti in 1 .. terms.size - 1) {
        out = out.add(terms[nti])
    }
    return out.stringify()
}

fun main() {

    if (fractionaladditionsubstraction("1/2+3/2") == "2/1") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("-5/2-3/2") == "-4/1") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("5/3-5/3") == "0/1") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("10/10-1/10+2/5") == "13/10") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (fractionaladditionsubstraction("1/6+1/6+1/6") == "1/2") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
