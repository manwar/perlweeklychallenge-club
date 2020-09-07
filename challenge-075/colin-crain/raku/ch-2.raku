#!/usr/bin/env perl6
# 
#
#         75_2_windows_wide_open.raku
#
#         TASK #2 › Largest Rectangle Histogram
#             Submitted by: Mohammad S Anwar
#             You are given an array of positive numbers @A.
# 
#             Write a script to find the larget rectangle histogram created by the
#             given array.
# 
#             BONUS: Try to print the histogram as shown in the example, if
#             possible.
# 
#         Example 1:
# 
#             Input: @A = (2, 1, 4, 5, 3, 7)
#                  7           #
#                  6           #
#                  5       #   #
#                  4     # #   #
#                  3     # # # #
#                  2 #   # # # #
#                  1 # # # # # #
#                  _ _ _ _ _ _ _
#                    2 1 4 5 3 7
# 
#             Looking at the above histogram, the largest rectangle (4 x 3) is
#             formed by columns (4, 5, 3 and 7).
# 
#             Output: 12
# 
#         Example 2:
# 
#             Input: @A = (3, 2, 3, 5, 7, 5)
#                  7         #
#                  6         #
#                  5       # # #
#                  4       # # #
#                  3 #   # # # #
#                  2 # # # # # #
#                  1 # # # # # #
#                  _ _ _ _ _ _ _
#                    3 2 3 5 7 5
#             Looking at the above histogram, the largest rectangle (3 x 5) is
#             formed by columns (5, 7 and 5).
# 
#         Output: 15
# 
#       
## ## ## ## ##
# 
#         method:
#             The rectangular area under a range is defined by the minimum value
#             within that range and the width of the span.
# 
#             So by looking at each range set within the bounds of the array, we
#             can find the corresponding minimum; multiplying that by the width
#             of the window gives us the area of the rectangle.
# 
#             We are asked to find the maximum rectangle, but if we wish to
#             allow for multiple equal areas, outputting all values, we need
#             to keep all the rectangle data and review it before reporting. We
#             can keep everything in an array of arrays, with a structure for
#             [Area, Start, End, Height] and descending sort by area. Take the
#             max value and find any others matching; these will
#             be the maximum rectangles.
# 
#             We will choose to not consider a single data point to be a proper
#             rectangle, more like a line, so in altering the input of example
#             number 2 to the list (3, 2, 3, 5, 7, 16), the result would still
#             be 15, being the rectangle with height 5 over (5,7,16), rather
#             than just the 16 value. It would be easy enough to fudge the
#             iterators to make it work that way, but I consider it to be a
#             degenerate and slightly boring case, overly sensitive to outliers
#             and signal noise. Let's keep it interesting and say rectangles
#             need at minimum width 2.
# 
#                 array 6 14 17 1 20 7 15 5 10 19 16 13
# 
#                 rectangle found at:
#                     start index 4
#                     end index   11
#                     height      5
#                     width       8
#                     area        40
# 
#                 rectangle found at:
#                     start index 8
#                     end index   11
#                     height      10
#                     width       4
#                     area        40#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

unit sub MAIN () ;

## cfg
my @A = (^24).pick(12);
my @windows;

## work
for (^@A.elems).combinations(2) -> ($start, $end) {
    my $min = @A[$start..$end].min;
    @windows.push: ($min*($start..$end).elems, $start, $end, $min);
}

my $max     = @windows.max({$_[0]});
my @largest = @windows.grep({ $_[0] == $max[0] });


## out
say "array ", @A, "\n";
for @largest -> @r {
    my $width = @r[2]-@r[1]+1;
    
    say qq:to/__EOD__/;
        rectangle found at:
            start index @r[1]
            end index   @r[2]
            height      @r[3]
            width       $width
            area        @r[0]
        __EOD__
}

