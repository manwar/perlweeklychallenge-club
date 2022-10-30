#!/usr/bin/env tclsh



set comment {

  ----------------------------------------------------------------------------------------------------------------------------

  AUTHOR: Robert DiCicco

  DATE: 2022-10-27

  Challenge 188 Total Zero ( Tcl )



  You are given two positive integers $x and $y.

  Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:



  $x = $x - $y if $x >= $y

  or

  $y = $y - $x if $y >= $x (using the original value of $x)

  ----------------------------------------------------------------------------------------------------------------------------



}



set given  { {5 4 } {4 6 } {2 5 } {3 1 } {7 4 }}



set step 0



proc steps {x y } {

  global step

  if {$x > $y} {

    set x [expr $x - $y]



  } elseif {$y > $x } {



    set y  [expr $y - $x]

  }

  incr step

  if { $x == $y } {

    incr step

    puts "Output: $step\n"

    return

   }

  steps $x $y

}



foreach item $given {

  set x  [lindex $item 0]

  set y  [lindex $item 1]

  puts "Input: \$x = $x,  \$y = $y"

  set step 0

  steps $x $y

}



set comment {

  ----------------------------------------------------------------------------------------------------------------------------

  SAMPLE OUTPUT

  PS G:\Projects\Perl\Challenges> tclsh .\TotalZero.tcl

  Input: $x = 5,  $y = 4

  Output: 5



  Input: $x = 4,  $y = 6

  Output: 3



  Input: $x = 2,  $y = 5

  Output: 4



  Input: $x = 3,  $y = 1

  Output: 3



  Input: $x = 7,  $y = 4

  Output: 5

}
