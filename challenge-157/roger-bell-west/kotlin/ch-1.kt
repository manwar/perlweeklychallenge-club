import kotlin.math.*

fun pythagoreanmeans(s: List<Int>): Map<String,Double> {
    return hashMapOf(
        "AM" to round1(arithmeticmean(s)),
        "GM" to round1(geometricmean(s)),
        "HM" to round1(harmonicmean(s))
    )
}

fun round1(x: Double): Double {
    return floor(10.0*x+0.5)/10.0;
}

fun arithmeticmean(s: List<Int>): Double {
    return s.reduce { acc, x -> acc + x }.toDouble() / s.size
}

fun geometricmean(s: List<Int>): Double {
    return s.reduce { acc, x -> acc * x }.toDouble().pow(1.0/s.size)
}

fun harmonicmean(s: List<Int>): Double {
    return s.size/(s.map {1.0/it}.reduce { acc, x -> acc + x })
}

fun main() {
    if (pythagoreanmeans(listOf(1,3,5,7,9)) == hashMapOf(
            "AM" to 5.0,
            "GM" to 3.9,
            "HM" to 2.8,
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (pythagoreanmeans(listOf(2,4,6,8,10)) == hashMapOf(
            "AM" to 6.0,
            "GM" to 5.2,
            "HM" to 4.4,
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (pythagoreanmeans(listOf(1,2,3,4,5)) == hashMapOf(
            "AM" to 3.0,
            "GM" to 2.6,
            "HM" to 2.2,
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
