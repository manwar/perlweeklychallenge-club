fun ascendingnumbers(a: String): Boolean {
    var prev: Int? = null
    for (c in a.split(" ")) {
        val n = c.toIntOrNull()
        if (n != null) {
            if (prev != null && prev >= n) {
                return false
            }
            prev = n
        }
    }
    return true
}

fun main() {

    if (ascendingnumbers("The cat has 3 kittens 7 toys 10 beds")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!ascendingnumbers("Bob has 10 cars 10 bikes")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ascendingnumbers("Zero is 0 one is 1 two is 2")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
