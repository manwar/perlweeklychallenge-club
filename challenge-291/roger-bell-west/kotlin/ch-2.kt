fun combinations(arr: List<Pair<Int, Int>>, k: Int): List<List<Pair<Int, Int>>> {
    var c = ArrayList<Int>()
    for (i in 0 .. k-1) {
        c.add(i)
    }
    c.add(arr.size)
    c.add(0)
    var out = ArrayList<List<Pair<Int, Int>>>()
    while (true) {
        var inner = ArrayList<Pair<Int, Int>>()
        for (i in k-1 downTo 0) {
            inner.add(arr[c[i]])
        }
        out.add(inner.toList())
        var j = 0
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j
            j += 1
        }
        if (j >= k) {
            break
        }
        c[j] += 1
    }
   return out.toList()
}

fun counterify(a: List<Int>): Map<Int, Int> {
    var cc = mutableMapOf<Int, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun main() {

    var deck = ArrayList<Pair<Int, Int>>()
    for (suit in 0 .. 3) {
        for (rank in 1 .. 13) {
            deck.add(Pair(rank, suit))
        }
    }

    var hands = mutableMapOf<Int, Int>().withDefault({0})
    for (hand in combinations(deck, 5)) {
        var bin = 0
        var ranks = hand.map{it.first}.toList()
        ranks = ranks.sorted()
        val ranksc = counterify(ranks)
        var ranksk = ranksc.values.toList().sorted().reversed()
        var suits = hand.map{it.second}.toList()
        suits = suits.sorted()
        val suitsc = counterify(suits)
        var suitsk = suitsc.values.toList().sorted().reversed()
        // Can't generate 5 of a kind.
        // Royal flush
        if (suitsc.size == 1 &&
            ranks == listOf(1, 10, 11, 12, 13)) {
            bin = 2
        }
        // Straight flush
        if (bin == 0 &&
            suitsc.size == 1 &&
            ranks.minOrNull()!! + 4 == ranks.maxOrNull()!!) {
            bin = 2
        }
        // Four of a kind
        if (bin == 0 && ranksk[0] == 4) {
            bin = 3
        }
        // Full house
        if (bin == 0 && ranksk[0] == 3 && ranksk[1] == 2) {
            bin = 4
        }
        // Flush
        if (bin == 0 && suitsk[0] == 5) {
            bin = 5
        }
        // Straight
        if (bin == 0 &&
            // match full rank struct
            (
                (ranks[0] + 1 == ranks[1] &&
                 ranks[1] + 1 == ranks[2] &&
                 ranks[2] + 1 == ranks[3] &&
                 ranks[3] + 1 == ranks[4])
                ||
                ranks == listOf(1, 10, 11, 12, 13))
        ) {
            bin = 6
        }
        // Three of a kind
        if (bin == 0 && ranksk[0] == 3) {
            bin = 7
        }
        // Two pair
        if (bin == 0 && ranksk[0] == 2 && ranksk[1] == 2) {
            bin = 8
        }
        // One pair
        if (bin == 0 && ranksk[0] == 2) {
            bin = 9
        }
        // Anything else is High card
        if (bin == 0) {
            bin = 10
        }
        hands.set(bin, hands.getValue(bin) + 1)
    }
    var tot = 0
    for (k in hands.keys.sorted()) {
        println(k.toString() + " " + hands.getValue(k).toString())
        tot += hands.getValue(k)
    }
    println("total " + tot.toString())
}
