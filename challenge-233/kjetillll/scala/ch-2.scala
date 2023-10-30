object happy {

  def main(args:Array[String]):Unit =
    if( args.size > 0 )
      println( frequency_sort( args.toList.map(_.toInt) ) )
    else
      run_tests

  def frequency_sort(ar:List[Int]):List[Int] = {
    val count = ar.groupBy(identity).view.mapValues(_.size)
    ar.sortBy( elem => ( count(elem), -elem ) )
  }

  def run_tests = {
    for{ test <- List(
      ( List(1,1,2,2,2,3),          List(3,1,1,2,2,2)          ),
      ( List(2,3,1,3,2),            List(1,3,3,2,2)            ),
      ( List(-1,1,-6,4,5,-6,1,4,1), List(5,-1,4,4,-6,-6,1,1,1) )
    )} {
      val input    = test._1
      val expected = test._2
      val got      = frequency_sort(input)
      val result   = if( got == expected ) "ok" else "***NOT OK"
      println( result + "   input: "+input+"   expected: "+expected+"   got: "+got )
    }
  }
}
