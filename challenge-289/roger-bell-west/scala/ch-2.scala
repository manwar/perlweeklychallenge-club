import scala.util.Random
import scala.util.matching.Regex
import scala.io.Source
// import scala.io.StdIn.readLine

object Jumbledletters {
  def jumble (a: String): String = {
    return Random.shuffle(a.split("").toList).mkString("")
  }
  def main(args: Array[String]) {
    val wordre = raw"([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])".r
    val input = Source.fromInputStream(System.in);
    for (line <- input.getLines) {
      println(wordre.replaceAllIn(line,
        m => m.group(1) + jumble(m.group(2)) + m.group(3)))
    }
  }
}
