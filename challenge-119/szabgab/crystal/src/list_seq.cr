require "./seq"

seq {|num|
  puts num
  break if num > 200
}
