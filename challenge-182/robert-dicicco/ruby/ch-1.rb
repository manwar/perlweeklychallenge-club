#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-12
# Challenge 182 Max Index ch-1.pl ( Ruby )

n_arr = [5, 2, 4, 1, 7, 6]

n_ndx = Hash.new;

count = 0;

n_arr.each { |x|

  n_ndx[x] = count

  count += 1

}

n_srt = n_arr.sort.reverse;

puts "Input: @n = #{n_arr}\n"

puts "Output: #{n_ndx[n_srt[0]]}\n"
