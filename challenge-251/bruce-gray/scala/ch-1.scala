// Run with `scala scala/ch-1.scala`
val task1 = ( ns: Array[Int] ) =>
    var i = 0
    var j = ns.length - 1
    var ret = 0

    while ( i <  j ) {
        ret += s"${ns(i)}${ns(j)}".toInt
        i += 1
        j -= 1
    }

    if i == j then
        ret += ns(i)

    ret


// Below this point is test harness and data
var test_number = 0
val is = ( got:Int, expected:Int, test_name:String ) =>
    test_number += 1
    val ok_msg = if (got == expected) then "ok" else "not ok"
    println(s"$ok_msg $test_number $test_name")

@main def TWC251_1(args: String*): Unit = {
    if (args.length > 0) {
        println(task1(args.map(_.toInt).toArray))
    }
    else {
        val arr = List(
            ( 1286, Array( 6, 12, 25, 1)       , "Task example 1" ),
            (  489, Array(10,  7, 31, 5, 2, 2) , "Task example 2" ),
            (  112, Array( 1,  2, 10)          , "Task example 3" ),
            (    0, Array[Int]()               , "Empty --> 0"    )
        )

        for (((expected, in, test_name)) <- arr) {
            is( task1( in ), expected, test_name )
        }
    }
}
