
fun specialaverage(a0: List<Int>): Int {
    val a = a0.sorted()
    val min = a[0]
    val max = a[a.size-1]
    val b = a.filter{it != min && it != max}
    if (b.size == 0) {
        return 0
    }
    return b.sum() / b.size
}

fun main() {

    if (specialaverage(listOf(8000, 5000, 6000, 2000, 3000, 7000)) == 5250) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialaverage(listOf(100000, 80000, 110000, 90000)) == 95000) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialaverage(listOf(2500, 2500, 2500, 2500)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialaverage(listOf(2000)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialaverage(listOf(1000, 2000, 3000, 4000, 5000, 6000)) == 3500) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
