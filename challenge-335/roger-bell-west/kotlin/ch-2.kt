fun findwinner(a: List<List<Int>>): String {
    var board = ArrayList(listOf(ArrayList(listOf(0, 0, 0)),
                                 ArrayList(listOf(0, 0, 0)),
                                 ArrayList(listOf(0, 0, 0))
    ))
    var player = 1
    for (play in a) {
        board[play[0]][play[1]] = player
        player = 3 - player
    }
    for (pattern in listOf(
             listOf(0, 0, 1, 0),
             listOf(0, 1, 1, 0),
             listOf(0, 2, 1, 0),
             listOf(0, 0, 0, 1),
             listOf(1, 0, 0, 1),
             listOf(2, 0, 0, 1),
             listOf(0, 0, 1, 1),
             listOf(0, 2, 1, -1)
    )) {
        var cellvals = mutableSetOf<Int>()
        for (i in 0 .. 2) {
            val x = pattern[0] + i * pattern[2]
            val y = pattern[1] + i * pattern[3]
            cellvals.add(board[y][x])
        }
        if (cellvals.size == 1) {
            var winner = cellvals.toList()[0]
            if (winner == 1) {
                return "A"
            } else if (winner == 2) {
                return "B"
            }
        }
    }
    if (a.size == 9) {
        return "Draw"
    } else {
        return "Pending"
    }
}

fun main() {

    if (findwinner(listOf(listOf(0, 0), listOf(2, 0), listOf(1, 1), listOf(2, 1), listOf(2, 2))) == "A") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwinner(listOf(listOf(0, 0), listOf(1, 1), listOf(0, 1), listOf(0, 2), listOf(1, 0), listOf(2, 0))) == "B") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwinner(listOf(listOf(0, 0), listOf(1, 1), listOf(2, 0), listOf(1, 0), listOf(1, 2), listOf(2, 1), listOf(0, 1), listOf(0, 2), listOf(2, 2))) == "Draw") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwinner(listOf(listOf(0, 0), listOf(1, 1))) == "Pending") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwinner(listOf(listOf(1, 1), listOf(0, 0), listOf(2, 2), listOf(0, 1), listOf(1, 0), listOf(0, 2))) == "B") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
