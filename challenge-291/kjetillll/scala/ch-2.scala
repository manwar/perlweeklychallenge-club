//scala3
//time scala ch-2.scala

def category( hand: Seq[(Int,Int)] ) = {
    val s = hand.map(_._1).sorted.reverse  //suits descending
    val r = hand.map(_._2).sorted.reverse  //ranks descending
    val all_same_suit = s(0)==s(4)
    val rs = r.mkString(" ")
    if      ( all_same_suit && rs=="12 11 10 9 0" )                  { "Royal flush"   }
    else if ( all_same_suit && r(0) == r(4)+4 )                      { "Straigh flush" }
    else if ( r(0)==r(3) )                                           { "Four"          }
    else if ( r(1)==r(4) )                                           { "Four"          }
    else if ( r(0)==r(2) && r(3)==r(4) )                             { "Full house"    }
    else if ( r(0)==r(1) && r(2)==r(4) )                             { "Full house"    }
    else if ( all_same_suit )                                        { "Flush"         }
    else if ( (r(1)-r(0))*(r(2)-r(1))*(r(3)-r(2))*(r(4)-r(3)) == 1 ) { "Straight"      }
    else if ( rs=="12 11 10 9 0" )                                   { "Straight"      } 
    else if ( r(0)==r(2) || r(1)==r(3) || r(2)==r(4) )               { "Three"         }
    else if ( r(0)==r(1) && r(2)==r(3)               )               { "Two pair"      } // 2+2+1
    else if ( r(0)==r(1) && r(3)==r(4)               )               { "Two pair"      } // 2+1+2
    else if ( r(1)==r(2) && r(3)==r(4)               )               { "Two pair"      } // 1+2+2
    else if ( r(0)==r(1) )                                           { "Pair"          }
    else if ( r(1)==r(2) )                                           { "Pair"          }
    else if ( r(2)==r(3) )                                           { "Pair"          }
    else if ( r(3)==r(4) )                                           { "Pair"          }
    else                                                             { "Hand"          }
}

def hand( cards: Seq[Int] ) = cards.map( c => ( (c-1)/13, (c-1)%13 ) )

val n = 52

val count = (for {
    c1 <- 1    to n-4
    c2 <- c1+1 to n-3
    c3 <- c2+1 to n-2
    c4 <- c3+1 to n-1
    c5 <- c4+1 to n
} yield category( hand( Seq(c1,c2,c3,c4,c5) ) ) ).groupBy(cat=>cat).map(key=>(key._1,key._2.size))

val countAll = count + (("Total",count.values.sum))

@main def main() = countAll.keys.toSeq.sortBy(countAll(_)).map(cat=>println(f"${cat+":"}%-20s ${countAll(cat)}%7d"))
