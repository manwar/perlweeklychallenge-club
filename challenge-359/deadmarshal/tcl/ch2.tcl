#!/usr/bin/env tclsh

proc stringReduction {s} {
  set res ""
  for {set i 0} {$i < [string length $s]} {incr i} {
    set char [string index $s $i]
    set len [string length $res]

    if {$len > 0 && [string index $res end] eq $char} {
      set res [string range $res 0 end-1]
    } else {
      append res $char
    }
  }
  return $res
}

set tests {
  "aabbccdd"
  "abccba"
  "abcdef"
  "aabbaeaccdd"
  "mississippi"
}

foreach test $tests {
  set result [stringReduction $test]
  puts "$test -> '$result'"
}

