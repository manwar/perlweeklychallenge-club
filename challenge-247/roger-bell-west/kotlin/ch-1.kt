fun secretsanta(name: List<String>): Boolean {
    val family: List<String> = name.map{n -> n.split(" ").last()}.toList()
    var receivers = generateSequence(0) { it + 1 }.take(name.size).toMutableSet()
    var gifting = ArrayList<List<String>>()
    for (giver in 0 .. name.size - 1) {
        var done = false
        var r = 0
        for (recipient in receivers) {
            if (family[giver] != family[recipient]) {
                r = recipient
                done = true
                break
            }
        }
        if (!done) {
            for (recipient in receivers) {
                if (giver != recipient) {
                    r = recipient
                    break
                }
            }
        }
        receivers.remove(r)
        gifting.add(listOf(name[giver], name[r]))
    }
    for (p in gifting) {
        print(p[0])
        print(" -> ")
        println(p[1])
    }
    println("")
    return true;
}

fun main() {

    if (secretsanta(listOf("Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secretsanta(listOf("Mr. Wall", "Mrs. Wall", "Mr. Anwar"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
