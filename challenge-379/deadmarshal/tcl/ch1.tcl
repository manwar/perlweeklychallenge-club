proc reverse {str} {
  set rev {}
  set i [string length $str]
  while {$i > 0} {
    incr i -1
    append rev [string index $str $i]
  }
  return [join $rev " "]
}

puts [reverse ""]
puts [reverse "reverse the given string"]
puts [reverse "Perl is Awesome"]
puts [reverse "v1.0.0-Beta!"]
puts [reverse "racecar"]

