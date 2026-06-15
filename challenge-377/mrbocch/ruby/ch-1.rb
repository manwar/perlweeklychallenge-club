def reverse_existence(str)
  cstr = str.chars
  p1 = cstr.each_cons(2).to_set()
  p2 = cstr.reverse.each_cons(2).to_set()

  p1.intersect?(p2)
end

raise if reverse_existence("abcba") != true 
raise if reverse_existence("racecar") != true 
raise if reverse_existence("abcd") != false 
raise if reverse_existence("banana") != true 
raise if reverse_existence("hello") != true 


