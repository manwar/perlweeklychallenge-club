#!/usr/bin/env perl6
# 
#
#       water_inside_a_duck.raku
#
#       TASK #2 › Trapped Rain Water
#         Submitted by: Mohammad S Anwar
#         You are given an array of positive numbers @N.
# 
#         Write a script to represent it as Histogram Chart and find out how
#         much water it can trap.
# 
#         Example 1:
#         Input: @N = (2, 1, 4, 1, 2, 5)
#         The histogram representation of the given array is as below.
#              5           #
#              4     #     #
#              3     #     #
#              2 #   #   # #
#              1 # # # # # #
#              _ _ _ _ _ _ _
#                2 1 4 1 2 5
#         Looking at the above histogram, we can see, it can trap 1 unit of rain
#         water between 1st and 3rd column. Similary it can trap 5 units of rain
#         water betweem 3rd and last column.
# 
#         Therefore your script should print 6.
# 
#         Example 2:
#         Input: @N = (3, 1, 3, 1, 1, 5)
#         The histogram representation of the given array is as below.
#              5           #
#              4           #
#              3 #   #     #
#              2 #   #     #
#              1 # # # # # #
#              _ _ _ _ _ _ _
#                3 1 3 1 1 5
#         Looking at the above histogram, we can see, it can trap 2 units of
#         rain water between 1st and 3rd column. Also it can trap 4 units of
#         rain water between 3rd and last column.
# 
#         Therefore your script should print 6.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;

@input.elems == 0 and @input = 9,12,10,6,8,6,9,6; 
my $vol;
say "histogram:\n";

for (@input.min..@input.max).reverse -> $level {
    my @peaks = @input.keys.grep({ @input[$_] >= $level });
    $vol += ($_[1] - $_[0] - 1) for @peaks.rotor(2=>-1);
    
    ## draw the histogram while we're looping through the levels
    say $level.fmt("%-2s | "), (^@input).map({ @input[$_] >= $level ?? '##' !! '  ' }).join: ' '; 
}

## out
say '---+' ~ '---' x @input.elems;
say '   | ' ~ @input.map(*.fmt("%-3s")).join ~ "\n";

say "volume: ", $vol;

