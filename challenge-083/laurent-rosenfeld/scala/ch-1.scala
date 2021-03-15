
object wordLength extends App {
  val instr = "The purpose of our lives is to be happy"
  val words = instr.split(" ")
  println(words.slice(1, words.length - 1).mkString.length)
}
// 23