fun championteam(a: List<List<Int>>): Int {
    var maxw = 0
    var teamw = ArrayList<Int>()
    a.forEachIndexed {i, w ->
                          val wins = w.sum()
                      if (wins > maxw) {
                          teamw = ArrayList<Int>()
                          maxw = wins
                      }
                      if (wins == maxw) {
                          teamw.add(i)
                      }
    }
    if (teamw.size == 1) {
        return teamw[0]
    }
    var bestt = teamw[0]
    for (rt in teamw) {
        if (a[rt][bestt] == 1) {
            bestt = rt
        }
    }
    return bestt
}

fun main() {

    if (championteam(listOf(listOf(0, 1, 1), listOf(0, 0, 1), listOf(0, 0, 0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (championteam(listOf(listOf(0, 1, 0, 0), listOf(0, 0, 0, 0), listOf(1, 1, 0, 0), listOf(1, 1, 1, 0))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (championteam(listOf(listOf(0, 1, 0, 1), listOf(0, 0, 1, 1), listOf(1, 0, 0, 0), listOf(0, 0, 1, 0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (championteam(listOf(listOf(0, 1, 1), listOf(0, 0, 0), listOf(0, 1, 0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (championteam(listOf(listOf(0, 0, 0, 0, 0), listOf(1, 0, 0, 0, 0), listOf(1, 1, 0, 1, 1), listOf(1, 1, 0, 0, 0), listOf(1, 1, 0, 1, 0))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
