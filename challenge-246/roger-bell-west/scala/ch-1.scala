import scala.util.Random

object Sixoffortynine {
  def sixoffortynine() {
    var candidates = List.range(1, 50)
    candidates = Random.shuffle(candidates)
    candidates = candidates.take(6)
    candidates = candidates.sortWith(_ < _)
    println(candidates)
  }
  def main(args: Array[String]) {
      sixoffortynine()
  }
}
