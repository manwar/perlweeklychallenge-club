fun f(x: Int): Int = x/2 + 1

fun g(x: Int): Int = x * 2

fun compose(f: (Int) -> Int,  g: (Int) -> Int): (Int) -> Int  = { f(g(it)) }

fun main() {
    for (i in 2..6) {
        println(compose(::f, ::g)(i))
    }
}
