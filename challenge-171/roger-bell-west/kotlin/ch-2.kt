fun compose(f1: (Int) -> Int, f2: (Int) -> Int): (Int) -> Int {
    return fun(x: Int): Int = f1(f2(x))
}

fun main() {
    val f = fun (x: Int): Int = x + 1
    val g = fun (x: Int): Int = x * 2
    val h = compose(f, g)
    for (i in 1..10) {
        if (f(g(i)) == h(i)) {
            print("Pass")
        } else {
            print("FAIL")
        }
        print(" ")
    }
    println("")
}
