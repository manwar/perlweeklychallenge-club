proc max_words {sentences} {
  set c [lmap sentence $sentences {llength [split $sentence]}]
  return [tcl::mathfunc::max {*}$c]
}

puts [max_words {"Hello world" "This is a test" "Perl is great"}]
puts [max_words {"Single"}]
puts [max_words {"Short" "This sentence has six words in total" 
  "A B C" "Just four words here"}]
puts [max_words {"One" "Two parts" "Three part phrase" ""}]
puts [max_words {"The quick brown fox jumps over the lazy dog" "A" 
  "She sells seashells by the seashore"
  "To be or not to be that is the question"}]

