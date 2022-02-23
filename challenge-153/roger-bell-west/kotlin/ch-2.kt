fun factorion(input: Int): Boolean {
    if (input == 0) {
        return false
    }
    var fd=ArrayList<Int>()
    fd.add(1)
    var ff=1
    for (i in 1..9) {
        ff *= i
        fd.add(ff)
    }
    var working=input
    var dsum=0
    while (working > 0) {
        dsum += fd[working % 10]
        working /= 10
    }
    return input == dsum
}

fun main() {
    if (factorion(145)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (!factorion(125)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
