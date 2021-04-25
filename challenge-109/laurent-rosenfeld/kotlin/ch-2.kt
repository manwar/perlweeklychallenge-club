fun <T> permute(input: List<T>): List<List<T>> {
    if (input.size == 1) return listOf(input)
    val perms = mutableListOf<List<T>>()
    val toInsert = input[0]
    for (perm in permute(input.drop(1))) {
        for (i in 0..perm.size) {
            val newPerm = perm.toMutableList()
            newPerm.add(i, toInsert)
            perms.add(newPerm)
        }
    }
    return perms
}

fun check_squares(p: List<Int>): Boolean  {
    val sum = p[0] + p[1]
    return ( p[1] + p[2] + p[3] == sum &&
             p[3] + p[4] + p[5] == sum &&
             p[5] + p[6] == sum )
}

fun main(args: Array<String>) {
    val input = listOf(1, 2, 3, 4, 5, 6, 7)
    val perms = permute(input)
    for (perm in perms) {
        if (check_squares(perm)) println(perm)
    }
}
