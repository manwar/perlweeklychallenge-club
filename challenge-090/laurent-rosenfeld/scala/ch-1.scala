object Dna extends App {
    import scala.collection.mutable.Map
    val dna = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";
    var result = ""
    var histo:Map[Char,Int] = Map('A' -> 0, 'T' -> 0, 'C' -> 0, 'G' -> 0)
    for (char <- dna.toCharArray()) {
        // println(char)
        val charout = char match {
            case 'T' => 'A'
            case 'A' => 'T'
            case 'C' => 'G'
            case 'G' => 'C'
            case _   => char
        }
        result += char
        histo(char) += 1
    }
    println(s"Complement: $result")
    for ((k,v) <- histo) println(s"$k: $v")
}
