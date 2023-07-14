fun maxwords(a: List<String>): Int {
    return a.map{it.count{it == ' '}}.maxOrNull()!! + 1
}

fun main() {

    if (maxwords(listOf("Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference.")) == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxwords(listOf("The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members.")) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
