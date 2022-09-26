#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-26
# Challenge 184 Sequence Number ( Ruby )

cnt = 0

arr = [ 'ab1234', 'cd5678', 'ef1342' ]

#arr = [ 'pq1122', 'rs3334' ]

print("Input: \@list = ( " )

arr.each do |a|

  print("#{a} ")

end

puts ")"

print("Output: ( ")

arr.each do |a|

  pt1 = a[0..1]

  pt2 = a[2..5]

  text1 = sprintf("%.2d", cnt );

  cnt += 1

  print("#{text1}#{pt2} ");

end

print(")\n");
