object nameGame extends App {
  val in: String = if (args.size == 1) args(0) else "Katie"
  val start =  in.substring(0, 1)
  val suffix = in.substring(1)
  val vowels = Map("A" -> 1, "E" -> 1, "I" -> 1, "O" -> 1, "U" -> 1)

  val bosuffix = if (start == 'B' || vowels.contains(start))
    s"bo-$suffix"  else s"bo-b$suffix"
  val fosuffix = if (start == 'F' || vowels.contains(start))
    s"fo-$suffix"  else s"fo-f$suffix"
  val mosuffix = if (start == 'M' || vowels.contains(start))
    s"mo-$suffix" else s"mo-m$suffix"

  println(s"$in, $in, $bosuffix")
  println(s"Bonana-fanna $fosuffix")
  println(s"Fee fi $mosuffix")
  println(s"$in!")
}
