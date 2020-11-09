#!/usr/bin/env perl6
# 
#
#       four-corners-off-a-twenty.raku
#
#         TASK #2 › Find Square
#         Submitted by: Mohammad S Anwar
#         You are given matrix of size m x n with only 1 and 0.
# 
#         Write a script to find the count of squares having all four corners
#         set as 1.
# 
#         Example 1:
#         Input: [ 0 1 0 1 ]
#                [ 0 0 1 0 ]
#                [ 1 1 0 1 ]
#                [ 1 0 0 1 ]
# 
#         Output: 1
#         Explanation:
#         There is one square (3x3) in the given matrix with four corners as 1
#         starts at r=1;c=2.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($r = 5, $c = 6) ;

srand 20201031;  ## anchor this for development or comparison
                 ## its a good example

sub four_corners ($r, $c, $size is copy, @matrix) {
    $size--;     ## square side includes corner element

    return 1 if (    @matrix[$r;$c]             == 1 
                  && @matrix[$r+$size;$c]       == 1 
                  && @matrix[$r;$c+$size]       == 1 
                  && @matrix[$r+$size;$c+$size] == 1 );
}

my @matrix.push: (0,1).roll($c) for ^$r;

.say for @matrix;
say '';

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;
my @output;

for 0..$rows-2 -> $r {
    for 0..$cols-2 -> $c {  
        next unless @matrix[$r;$c];
        for 2..min($rows,$cols) -> $size {
            last if (($c + $size > $cols) || ($r + $size > $rows));
            
            if four_corners( $r, $c, $size, @matrix) {
                @output.push: ($r, $c, $size);
            }
        }
    }
}

say "found ", @output.elems, " squares:\n";

for sort {$^a[2] leg $^b[2]}, @output -> $s {
    printf "column %d row %d from top - square of size %d\n", 
            $s[1]+1, $s[0]+1, $s[2];
}
