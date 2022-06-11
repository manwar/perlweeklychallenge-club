fun main() {
    var fact = 1
    var left_fact = 1
    for (i in 1..9) {
        fact *= i
        left_fact += fact
        print("$left_fact ")
    }
}
