#!/usr/bin/env tclsh



set comment {

  AUTHOR: Robert DiCicco

  DATE: 2022-10-31

  Challenge 189 Greater Character ( Tcl )



  You are given an array of characters (a..z) and a target character.

  Write a script to find out the smallest character in the given array

  lexicographically greater than the target character.

}



proc TestValues { a tg } {

  puts "Input: @array = ($a), target = $tg"

  set out {}

  set x [llength $a]



  for {set i 0} {$i < $x} {incr i} {

    set v1 [lindex $a $i]

    if {[string compare $v1 $tg] == 1} {

      lappend out $v1

    }

   }

   set x [llength $out]

   if {$x > 0} {

   set out [lsort $out]

   } else {

    lappend out $tg

   }

   puts "Output: [lindex $out 0]\n"

}



proc main {} {

  set arr {{e m u g} {d c e f}  {j a r} {d c a f} {t g a l}}

  set target {b a o a v }

  set cnt 0

  foreach a $arr {

    set tg [lindex $target $cnt]

    incr cnt

    TestValues $a $tg

  }

}



main



set comment {

  -------------------------------------------------------

  SAMPLE OUTPUT

  PS G:\Projects\Perl\Challenges> tclsh .\GreateChar.tcl

  Input: @array = (e m u g), target = b

  Output: e



  Input: @array = (d c e f), target = a

  Output: c



  Input: @array = (j a r), target = o

  Output: r



  Input: @array = (d c a f), target = a

  Output: c



  Input: @array = (t g a l), target = v

  Output: v

}
