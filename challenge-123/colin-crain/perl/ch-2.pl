#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       no-room-for-squares.pl
#
#         Square Points
#         Submitted by: Mohammad S Anwar
#         You are given coordinates of four points i.e. 
#                 (x1, y1), (x2, y2), (x3, y3) and (x4, y4).
# 
#         Write a script to find out if the given four points form a square.
# 
#         Example
#         Input: x1 = 10, y1 = 20
#                x2 = 20, y2 = 20
#                x3 = 20, y3 = 10
#                x4 = 10, y4 = 10
#         Output: 1 as the given coordinates form a square.

            
# 
#         Input: x1 = 12, y1 = 24
#                x2 = 16, y2 = 10
#                x3 = 20, y3 = 12
#                x4 = 18, y4 = 16
#         Output: 0 as the given coordinates doesn't form a square.
#           
#         method:
#         
#             there are two ways to look at this problem that I see: the easy
#             problem and the harder version. The easy problem, as in first
#             example, is to identify a square in orthogonal alignment with the
#             coordinate system. In the more complex version we should consider
#             a square: (1,1), (5,2), (4,6), (0,5) which is canted one unit
#             counterclockwise.
# 
#             So how can we mathematically identify a square? Some properties of
#             squares would be in order. A square has:
#                 1. four vertex angles summing to 360°
#                 2. parallel opposing edges 
#                 3. four equal angles at the vertices
#                 4. four sides of equal length
#                 
#             The properites correspond to a square being, in increasing constraint:
#                 1. a quadralateral
#                 2. a parallelogram
#                 3. a rectangle
#                 4. a regular rectangle. 
#                 
#             This last constraint, of equalateral sides, without the previous,
#             equiangular vertices, can also identify a rhombus. If the four
#             equiangular vertices sum to 360°, the individual angles must be
#             right angles, at 90°.
# 
#             What we don't need to prove all of these assertions, only enough
#             to eliminate the poossibilites that the shape is *not* a square.
#             We can do this by showing that in the complete graph described by
#             the four points we have four edges the same length and two edges
#             the same length. We could be more specific and require the two
#             differing edged to hold the relationship 1:√2, but if the two
#             alternate lengths are diagonals, they will need to be equal to
#             form a square, and if they are not both diagonals they cannot be
#             equal. If neither is a diagonal the edges cannot be the same
#             length without multiple sets of points occupying the same
#             position, and we no longer have a quadralateral if a connecting
#             edge has zero length.
# 
#             Unfortunately there does exist one polygon that defeats this
#             analysis (see? I'm brutal about breaking my own algorithms too)
#             and that is most easily described as taking an equilateral
#             triangle, with three edges te same length, and extending a new
#             unit-length edge from one vertex perpendicular to the opposing
#             edge, out away from the triangle. These four edges are two sides
#             and two diagonals of a concave polygon made by conecting the point
#             on the far end of the new line to each of the two other vertices. 
#             
#                         A           
#                         |           AB, BC, BD and CD are the unit value
#                         |           
#                         |           connect AC and AD, and
#                         B           
#                        / \          the polygon is AC -> CB -> BD -> DA
#                       /   \         
#                      /     \        known as a "flying vee" shape
#                     C _ E _ D       
#                     
#             No one ever said the points needed to describe a *convex* polygon.

#             This suggests we need an additional check, but fortunately we can
#             still avoid having to deal directly with the square root of 2, as
#             we can derive the length of the two equal segments AC and AD.
# 
#             The line AE has length
# 
#                 1 + (√3/2)
# 
#             and the length of AE is 1/2. Using Pythagoras' theorem, the length
#             of AC is
# 
#                 √(2+√3) ≅ 1.93
# 
#             The square root of 2 plus some positive value will always be
#             greater than √2, so we don't need to directly compare to some
#             irrational number. If we're less than 1.5 the unit value we're
#             good. 
            
            
#                 
                
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub is_square ($pts) {
    my @pts = $pts->@*;
    my @dist;
    
    ## get distance list for all edges in complete graph of points
    for my $idx (0..2) {
        push @dist, map { euclidean( $pts[$idx], $pts[$_] )} ( $idx+1..3 )
    }
    
    ## makes sure only 2 values for length
    my ($v1, $c1, $v2, $c2) = ( shift @dist, 1, undef, 0);
    for (@dist) {
        if ( $_ == $v1 ) { $c1++; next }
        $v2 //= $_;
        if ( $_ == $v2 ) { $c2++; next }
        return 0;
    }

    ## order lengths to "sides" first, fail if not 4 
    if ( $c1 < $c2 ) { ($v1, $c1, $v2, $c2) = ($v2, $c2, $v1, $c1) } 
    return 0 unless $c1 == 4;
    
    ## fail unless 2 remaining sides are less than 1.5 x short side
    ## this is the concave polygon case
    return 0 unless $v2 < 1.5 * $v1;
    
    return 1;
}


sub euclidean ($pt1, $pt2) {
    return sqrt( ($pt1->[0] - $pt2->[0])**2 + ($pt1->[1] - $pt2->[1])**2 );
}





use Test::More;

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

done_testing();
