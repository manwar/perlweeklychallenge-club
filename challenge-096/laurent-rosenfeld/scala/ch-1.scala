object reverseWords extends App {
  val in = "    Perl and   Raku are  part of the same family  "
  println(in.split("\\s+").reverse.mkString(" "))
}
