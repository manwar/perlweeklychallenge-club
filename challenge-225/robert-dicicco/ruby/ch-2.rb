#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-11
Challenge 225 Task 2 Left Right Sum Diff ( Ruby )
---------------------------------------
=end
#array = [1, 2, 3, 4, 5]
array = [10,4,8,3]
$left = Array.new();
$right = [];
$left_right_sum_diff = [];

def ltr(array)
    sum = 0
    $left.push(0)
    ln = array.length()
    (0..ln-2).each do |x|
        sum += array[x];
        $left.push(sum);
    end
    puts("\t@left = #{$left}")
    #puts("#{$Left[0]}")
end

def rtl(array)
    sum = 0;
    $right.push(0);
    i = array.length - 1;
    while i > 0
        sum += array[i];
        $right.push(sum);
        i -= 1;
    end
    $right = $right.reverse()
    puts("\t@right = #{$right}")
end

puts("Input:  \@ints = #{array}");
ltr(array)
rtl(array)
i = 0;
while i < array.length
    val = ($left[i] - $right[i]).abs
    $left_right_sum_diff.push(val)
    i += 1
end
puts("\tOutput: @left_right_sum_diff = #{$left_right_sum_diff}")

=begin
---------------------------------------
SAMPLE OUTPUT
ruby LRSD.rb
Input:  @ints = [1, 2, 3, 4, 5]
        @left = [0, 1, 3, 6, 10]
        @right = [14, 12, 9, 5, 0]
        Output: @left_right_sum_diff = [14, 11, 6, 1, 10]

ruby LRSD.rb
Input:  @ints = [10, 4, 8, 3]
        @left = [0, 10, 14, 22]
        @right = [15, 11, 3, 0]
        Output: @left_right_sum_diff = [15, 1, 11, 22]
---------------------------------------
=end


