import scala.collection.mutable.Map
object anagrams extends App {
  val test =
    List("opt", "bat", "saw", "tab", "pot", "top", "was", "x")
  var words = Map.empty[String, Array[String]];
  for (word <- test) {
    val normalized = word.split("").sorted.mkString("")
    if (words contains normalized) {
      words(normalized) :+= word
    } else {
      words += (normalized -> Array(word))
    }
  }
  for (key <- words.keys) {
    println ("[" + words(key).mkString(" ") + "]")
  }
}
