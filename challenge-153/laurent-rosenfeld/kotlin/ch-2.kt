fun main() {
    var fact = mutableListOf<Int>()
    fact.add(1)
    for (n in 1..9) {
        fact.add(n * fact[n-1])
    }
    for (num in 1..50000) {
        var i = num
        var sum = 0
        while (i > 0) {
            sum += fact[i % 10]
            i /= 10
        }
        if (num == sum) print ("$num ")
    }
}
