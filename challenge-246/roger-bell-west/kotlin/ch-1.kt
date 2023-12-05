fun sixoffortynine() {
    var candidates = (1..49).toList()
    candidates = candidates.shuffled()
    candidates = candidates.take(6)
    candidates = candidates.sorted()
    println(candidates)
}

fun main() {
    sixoffortynine()
}
