object firstUnique extends App {
  import scala.collection.mutable.Map
  val tests: List[String] =
    List("Perl Weekly Challenge", "Long Live Perl")
  for (test <- tests) {
    val chars = test.split("")
    var histo: Map[String, Int] = Map()
    for (ch <- chars) {
      if (histo.contains(ch)) {
        histo(ch) = histo(ch) + 1
      } else {
        histo += (ch -> 1)
      }
    }
    var continue = true
    var i = 0
    while (continue) {
      if (histo(chars(i)) == 1) {
        println(test + ": " + i)
        continue = false

      }
      i = i + 1
    }
  }
}
