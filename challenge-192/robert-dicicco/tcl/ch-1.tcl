#!/usr/bin/env tclsh



set comment {

  AUTHOR: Robert DiCicco

  DATE: 2022-11-21

  Challenge 192 Binary Flip ( Tcl )



  You are given a positive integer, $n.



  Write a script to find the binary flip.

  Example 1



  Input: $n = 5

  Output: 2



  First find the binary equivalent of the given integer, 101.

  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.

  So Binary 010 => Decimal 2.

}



set arr { 5 4 6 }



proc dec2bin int {

  set binRep [binary format c $int]

  binary scan $binRep B* binStr

  return [string trimleft $binStr 0]

}



foreach n $arr {

  set out {}

  puts "Input: \$n = $n"

  set retval [ dec2bin $n]

  foreach char [split $retval ""] {

    if {$char == "1"} { lappend out "0"} else { lappend out "1"}

   }

  set stripped [string map {" " ""} $out]

  set dec [expr "0b$stripped"]

  puts "Output: $dec\n"

}



set comment {

SAMPLE OUTPUT



tclsh .\BinaryFlip.tcl

Input: $n = 5

Output: 2



Input: $n = 4

Output: 3



Input: $n = 6

Output: 1



}
