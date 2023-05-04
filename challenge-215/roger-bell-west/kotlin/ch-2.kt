fun numberplacement(a0: List<Int>, ct: Int): Boolean {
    var a = ArrayList<Int>()
    a.add(1)
    a.addAll(a0)
    a.add(1)
    var s = 0
    var tt = 0
    for (i in 1 .. a.size - 1) {
        if (a[i - 1] == 1 && a[i] == 0) {
            s = i
        } else if (a[i - 1] == 0 && a[i] == 1) {
            tt += (i - s) / 2
        }
    }
    return ct <= tt
}

fun main() {

    if (numberplacement(listOf(1, 0, 0, 0, 1), 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!numberplacement(listOf(1, 0, 0, 0, 1), 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (numberplacement(listOf(1, 0, 0, 0, 0, 0, 0, 0, 1), 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
