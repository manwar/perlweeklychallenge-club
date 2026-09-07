import scala.collection.mutable.ListBuffer

object Reordernotes {
  def reordernotes(composer: String, notes: List[String], order: List[Int]): Map[String, List[String]] = {
    var out = List.fill(order.size)("").to[ListBuffer]
    for ((n, i) <- order.zipWithIndex) {
      out(n - 1) = notes(i)
    }
    List(composer -> out.toList).toMap
  }
  def main(args: Array[String]) {
    if (reordernotes("Mozart", List("C", "D", "E", "F", "G", "A", "B"), List(7, 1, 6, 2, 5, 3, 4)) == Map[String, List[String]]("Mozart" -> List("D", "F", "A", "B", "G", "E", "C"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reordernotes("Chopin", List("C", "C#", "D", "D#", "E", "F"), List(6, 5, 4, 3, 2, 1)) == Map[String, List[String]]("Chopin" -> List("F", "E", "D#", "D", "C#", "C"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reordernotes("Vivaldi", List("A", "B", "C", "D", "E"), List(1, 2, 3, 4, 5)) == Map[String, List[String]]("Vivaldi" -> List("A", "B", "C", "D", "E"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reordernotes("Debussy", List("C", "D", "F", "G", "A"), List(1, 3, 5, 2, 4)) == Map[String, List[String]]("Debussy" -> List("C", "G", "D", "A", "F"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (reordernotes("Stravinsky", List("C#"), List(1)) == Map[String, List[String]]("Stravinsky" -> List("C#"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
