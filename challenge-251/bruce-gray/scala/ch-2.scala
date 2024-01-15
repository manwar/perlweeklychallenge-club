// Run with `scala scala/ch-2.scala`
val task2 = ( matrix: List[List[Int]] ) =>

    val column_maxes = matrix(0).indices.map(j => {
        matrix.map{_(j)}.max
    })

    var ret = -1
    import scala.util.control.Breaks._
    breakable {
        for (row <- matrix) {
            // Minimums can occur more than once in a row
            val min_col_value = row.min
            val min_col_indexes = row.indices.filter(j => row(j) == min_col_value)

            if ( min_col_indexes.exists(j => min_col_value == column_maxes(j)) ) {
                ret = min_col_value
                break
            }
        }
    }
    ret


// Below this point is test harness and data
var test_number = 0
val is = ( got:Int, expected:Int, test_name:String ) =>
    test_number += 1
    val ok_msg = if (got == expected) then "ok" else "not ok"
    println(s"$ok_msg $test_number $test_name")

@main def TWC251_2(): Unit = {
    val arr = List(
        ( 15, List( List( 3,  7,  8    ), List( 9, 11, 13    ), List(15, 16, 17    ) ), "Task example 1" ),
        ( 12, List( List( 1, 10,  4,  2), List( 9,  3,  8,  7), List(15, 16, 17, 12) ), "Task example 2" ),
        (  7, List( List( 7,  8        ), List( 1,  2        )                       ), "Task example 3" ),
        (  3, List( List( 3,  3,  3    ), List( 3,  9,  9    ), List( 3, 3, 3      ) ), "3&9" ),
        (  3, List( List( 9,  3, 15    ), List( 9,  3, 15    ), List( 9, 3, 15     ) ), "3,9,15" ),
        ( -1, List( List( 1,  5,  8    ), List( 2,  6,  4    ), List( 7, 3, 9      ) ), "-1"  ),
    )

    for (((expected, in, test_name)) <- arr) {
        is( task2(in), expected, test_name )
    }
}
