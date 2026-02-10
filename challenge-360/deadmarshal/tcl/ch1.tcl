proc text_justifier {str width} {
  set diff [expr {$width - [string length $str]}]
  if {$diff < 0} {
    error "Length too short!"
  }
  set l [expr {$diff / 2}]
  set r [expr {$diff - $l}]
  return "[string repeat "*" $l]${str}[string repeat "*" $r]"
}

puts [text_justifier "Hi" 5]
puts [text_justifier "Code" 10]
puts [text_justifier "Hello" 9]
puts [text_justifier "Perl" 4]
puts [text_justifier "A" 7]
puts [text_justifier "" 5]

