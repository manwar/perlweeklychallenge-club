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

fun uniquefractiongenerator(a: Int): List<String> {
    var den = 1
    for (dn in 2 .. a) {
        den *= dn
    }
    var f = mutableSetOf<Int>()
    for (d in 1 .. a) {
        val nd = den / d
        for (n in 1 .. a) {
            f.add(n * nd)
        }
    }
    var out = ArrayList<String>()
    for (n in f.sorted()) {
        val g = gcd(n, den)
        val nn = n / g
        val nd = den / g
        out.add(nn.toString() + "/" + nd.toString())
    }
    return out
}

fun main() {

    if (uniquefractiongenerator(3) == listOf("1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(4) == listOf("1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(1) == listOf("1/1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(6) == listOf("1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquefractiongenerator(5) == listOf("1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
