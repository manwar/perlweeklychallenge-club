object happy {

  def main(args:Array[String]):Unit
  = println(                     // use input from command line or else run three tests
      (
      if( args.size > 0 )                                     
        Seq( args )
      else
        Seq(
          Array("aba", "aabb", "abcd", "bac", "aabc"),
          Array("nba", "cba", "dba"),
          Array("aabb", "ab", "ba")
        )
      ).map( similar_pairs_count )
  )

  def letters(word:String):String
  = word.sortWith(_<_).distinct                            // return string of unique sorted chars in input

  def is_similar(w1:String, w2:String):Boolean
  = w1 != w2  &&  letters(w1) == letters(w2)

  def similar_pairs_count( word: Array[String] ):Int
  = ( for( i <- 0 to word.size-2; j <- i+1 to word.size-1 if is_similar( word(i), word(j) ) ) yield 1 ).sum

}
