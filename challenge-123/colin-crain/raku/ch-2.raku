#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;
plan 8;

is is_square( [ [10,20], [20,20], [20,10], [10,10] ] ), 1   
            , 'ex-1';
is is_square( [ [1,1], [5,2], [4,6], [0,5] ] ), 1           
            , 'racked 1 ccw';
is is_square( [ [12,24], [16,10], [20,12], [18,16] ] ), 0   
            , 'ex-2';
is is_square( [ [1,5], [5,5], [9,5], [1,1] ] ), 0           
            , 'parallelogram';
is is_square( [ [1,5], [5,1], [9,5], [5,9] ] ), 1           
            , 'regular diamond';
is is_square( [ [-5,0], [0,-5], [5,0], [0,5] ] ), 1         
            , 'regular diamond around origin';
is is_square( [ [-2,-3], [3,-3], [3,2], [-2,2] ] ), 1       
            , 'off-center around origin';
is is_square( [ [-4,-1], [1,-5], [5,0], [0,4] ] ), 1        
            , 'off-center around origin, rotate 2 cw';



sub is_square ( @pts ) {
    my @distances;
    
    for 0..2 -> $idx {
        @distances.push: |($idx+1..3).map({ euclidean( @pts[$idx], @pts[$_] )})
    }
    ## makes sure we have only 2 values for length
    my ($v1, $c1, $v2, $c2) = @distances.shift, 1, False, 0;
    for @distances {
        if $_ == $v1     { $c1++; next }
        $v2 ||= $_;
        if $_ == $v2     { $c2++; next }
        return 0;
    }
    ## reorder lengths to edges, fail if $v1 is not 4 equal sides
    if $c1 < $c2 { ($v1, $c1, $v2, $c2) = ($v2, $c2, $v1, $c1) } 
    return 0 unless $c1 == 4;
    
    ## fail unless 2 remaining sides are less than 1.5 x short side
    ## this is the concave polygon case
    return 0 unless $v2 < 1.5 * $v1;
    
    return 1;
}


sub euclidean ( @pt1, @pt2 ) {
    sqrt( (@pt1[0]-@pt2[0])**2 + (@pt1[1]-@pt2[1])**2 );
}




