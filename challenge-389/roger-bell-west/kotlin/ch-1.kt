fun reordernotes(composer: String, notes: List<String>, order: List<Int>): HashMap<String, List<String>> {
    var out = ArrayList((1 .. order.size).map{""})
    order.forEachIndexed { i, n ->
                               out[n - 1] = notes[i];
    }
    return hashMapOf(composer to out)
}

fun main() {

    if (reordernotes("Mozart", listOf("C", "D", "E", "F", "G", "A", "B"), listOf(7, 1, 6, 2, 5, 3, 4)) == hashMapOf("Mozart" to listOf("D", "F", "A", "B", "G", "E", "C"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reordernotes("Chopin", listOf("C", "C#", "D", "D#", "E", "F"), listOf(6, 5, 4, 3, 2, 1)) == hashMapOf("Chopin" to listOf("F", "E", "D#", "D", "C#", "C"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reordernotes("Vivaldi", listOf("A", "B", "C", "D", "E"), listOf(1, 2, 3, 4, 5)) == hashMapOf("Vivaldi" to listOf("A", "B", "C", "D", "E"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reordernotes("Debussy", listOf("C", "D", "F", "G", "A"), listOf(1, 3, 5, 2, 4)) == hashMapOf("Debussy" to listOf("C", "G", "D", "A", "F"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reordernotes("Stravinsky", listOf("C#"), listOf(1)) == hashMapOf("Stravinsky" to listOf("C#"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
