proc word_sorter {str} {
  set words [regexp -all -inline {\S+} $str]
  return [join [lsort -nocase $words] " "]
}

puts [word_sorter "The quick brown fox"]
puts [word_sorter "Hello    World!   How   are you?"]
puts [word_sorter "Hello"]
puts [word_sorter "Hello, World! How are you?"]
puts [word_sorter "I have 2 apples and 3 bananas!"]

