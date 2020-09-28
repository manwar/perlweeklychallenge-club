#! /opt/local/bin/perl
#
#       water_inside_a_duck.pl
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
#       method:

#             Water falls from the sky and gathers, so that's where we'll start,
#             at the top, descending.  As we traverse the range from maximum to minimum, each level
#             of the histogram is examined and an array is created from the
#             indices of elements that extend to that height or
#             beyond. A single result represents the solitary highest point that in
#             itself cannot contain a volume, but any two adjectant elements in
#             this array represent a gap that, given the opportunity, will fill
#             with water. 
# 
#             Water is assumed to collect in the spaces between the boundries of
#             the histogram columns, thus it is the non-inclusive interstitial
#             gap between a pair of indices that represents an expanse of water
#             at a depth of one unit. Adjacent indices will simply have a gap of
#             zero and thus will not fill. For each pair of indices, this is a
#             volume of water collected. Examining in turn each adjacent pair of
#             elements in the level array, a running tally gathers the total
#             volume of water at that level. Repeating this process as we
#             descend down the histogram, until we arrive at the minimum value,
#             yields the total valume of water trapped by the whole structure. 

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input = @ARGV;

@input = (3,6,3,1,1,5) if scalar @ARGV == 0;

my ($min,$max) = (sort {$a-$b} @input)[0,$#input];

say "histogram:\n";

my $vol;
for my $level (reverse($min..$max)) {
    my @peaks = grep { $input[$_] >= $level } (0..$#input);

    ## draw the histogram while we're here
    say "$level ", join ' ', map { $input[$_] >= $level ? '#' : ' ' } (0..$#input);

    while (scalar @peaks > 1) {
        my $start_idx = shift @peaks;
        $vol += $peaks[0] - $start_idx - 1;
    }
}

## out
say join ' ', ("-") x (scalar @input + 1);
say '  ', join ' ', @input;

say "\nvolume: $vol";
