#!/usr/bin/env perl6
#
#
#       pyramid-power.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;
plan 3;

is findpath( [[1], [2,3], [4,5,6], [7,8,9,10]] ), 14, "BFO triangle test";
is findpath( [[1], [2,4], [6,4,9], [5,1,7,2]] ) , 8, "ex-1";
is findpath( [[3], [3,1], [5,2,3], [4,3,1,3]] ) , 7, 'ex-2';

sub findpath (@arr) {
## the data structure: [ sum, [arr of values along path], last index ] 

    my $root = @arr[0][0];
    my @root = [$root, [$root], 0];
    my @data.push: @root; 
 
    for 0..@arr.elems-2 -> $depth {
        for 0..2**$depth-1 -> $pos {
            my $path = @data.shift;
            for 0,1 {
                my ($sum, $trace, $last) = $path;
                my $value   = @arr[$depth+1][$last+$_];
                my @newpath = $sum + $value,
                              [|$trace, $value],
                              $last + $_ ;
                push @data, @newpath;
            }
        }
    }
    
    ## a little verbose output
    my $minpath = @data.min( { $^a[0] } );
    
    say '';
    say "minimum path sum: ", $minpath[0];
    say "path:";
    say $minpath[1].join: ' -> ';

    ## the requested value
    return $minpath[0];
}

