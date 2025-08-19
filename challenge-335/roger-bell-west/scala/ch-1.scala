import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Commoncharacters {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }

  def commoncharacters(a: List[String]): List[String] = {
    var mc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    var first = true
    for (s <- a) {
      val mk = counterify(s.toCharArray.toList)
      if (first) {
        mc = collection.mutable.Map() ++ mk
        first = false
      } else {
        for (k <- mc.keys) {
          if (mk.contains(k)) {
            mc += ((k, List(mc(k), mk(k)).min))
          } else {
            mc.remove(k)
          }
        }
      }
    }
    var out = new ListBuffer[String]
    for (c <- mc.keys.toList.sortWith(_ < _)) {
      val s = c.toString
      for (n <- 1 to mc(c)) {
        out += s
      }
    }
    out.toList
  }

  def main(args: Array[String]) {
    if (commoncharacters(List("bella", "label", "roller")) == List("e", "l", "l")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (commoncharacters(List("cool", "lock", "cook")) == List("c", "o")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (commoncharacters(List("hello", "world", "pole")) == List("l", "o")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (commoncharacters(List("abc", "def", "ghi")) == List()) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (commoncharacters(List("aab", "aac", "aaa")) == List("a", "a")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
