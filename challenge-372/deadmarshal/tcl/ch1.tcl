proc rearrange_spaces {str} {
  set c [regexp -all { } $str]
  set words [split [string trim $str]]
  set words [lsearch -all -inline -not $words ""]
  set num_words [llength $words]

  if {$num_words > 1} {
    set width [expr {$c / ($num_words - 1)}]
    set rest [expr {$c % ($num_words - 1)}]
  } else {
    set width 0
    set rest $c
  }
  set res [join $words [string repeat " " $width]]
  append res [string repeat " " $rest]
  return $res
}

puts [rearrange_spaces "  challenge  "]
puts [rearrange_spaces "coding  is  fun"]
puts [rearrange_spaces "a b c  d"]
puts [rearrange_spaces "  team      pwc  "]
puts [rearrange_spaces "   the  weekly  challenge  "]

