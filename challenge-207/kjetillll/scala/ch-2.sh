#!/usr/bin/env scala

def H_index ( cit: List[Int], is_sorted: Boolean = false ): Int = {
  if      ( cit.isEmpty           ) 0
  else if ( !is_sorted            ) H_index( cit.sorted, true )
  else if ( cit.length > cit.head ) H_index( cit.tail, true)
  else                              cit.length
}
println( H_index( List(3,4,5,8,10) ) )  // 4
println( H_index( List(3,3,5,8,25) ) )  // 3
println( H_index( List(8,5,25,3,3,2,1,1,1,1) ) )  // 3
println( H_index( List(10,8,5,5,5) ) )  // 5
println( H_index( List(25,1,1,1) ) )    // 1
println( H_index( List(25) ) )          // 1
println( H_index( List() ) )            // 0

// chmod +x ch-2.sh
// ./ch-2.sh
// 4
// 3
// 3
// 5
// 1
// 1
// 0
