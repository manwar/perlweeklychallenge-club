#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       whos-masking-the-mask.pl
#
#         Rectangle Area
#         Submitted by: Mohammad S Anwar
# 
#         You are given coordinates bottom-left and top-right corner of 
#         two rectangles in a 2D plane.
# 
#         Write a script to find the total area covered by the two rectangles.
# 
#         Example 1:
#             Input: Rectangle 1 => (-1,0), (2,2)
#                    Rectangle 2 => (0,-1), (4,4)
#     
#             Output: 22
# 
#         Example 2:
#             Input: Rectangle 1 => (-3,-1), (1,3)
#                    Rectangle 2 => (-1,-3), (2,2)
#     
#             Output: 25
 
#         analysis:
# 
#             I like it when the puzzle doesn't explain itself in too much
#             detail as to what's going on with it. Here we are given two
#             rectangles and asked to find the area covered by both. Ok,
#             sure. Deriving the area involves the application of a fairly
#             simple formula. Do that for each and there we are.
# 
#             But what if the rectangles overlap? Oh, right. That's the
#             puzzle. The part that isn't mentioned.
# 
#             If we simply sum the two areas, any overlap will be counted
#             twice. We can't have that. What to do?
# 
#             We need to find that overlap, that's what, and do somehing
#             about it. Stat.
# 
#             What we are looking for then is the *union* of the two areas.
#             For this we take the area covered only by one rectangle, the
#             area covered only by the other, the area covered by both, and
#             then we add all of that up. Or, you know, come to the same
#             answer some other way. Like if we could find just the
#             intersection area, we could subtract that from the sum of
#             each considered independantly. That would work too.
# 
#             So what is the overlap, then? We keep coming back to that
#             question. Let's answer it.
# 
#             In the first example, we have two z-axis ranges, one for each
#             rectangle...
# 
#             Oh right. Before we begin, we'll note that two points only
#             determine a rectangle if it is laid out orthogonally on the
#             plane. If we allow the shape to be rotated, which of course
#             is prefectly allowable in a 2-dimensional cartesion space,
#             then we lose the meaning of the "bottom-left" and "top-right"
#             corners as distinct properties. Although one (or two) points
#             will always be bottom-most, unless we are orthogonally
#             aligned that point will not also be left-most. The whole idea
#             gets schmurtled.
# 
#             So because we are only given the two points to define our
#             rectangle, we can safely infer that that the two rectangles
#             are orthogonally placed within the grid. This is good,
#             because calculating teh area in arbitrarily-rotated
#             rectangles is considerably harder to do. Not impossible, but
#             much more complicated.
# 
#             That settled,  we have two x-axis ranges, one for each
#             rectangle. Any overlapped area will be contained within the
#             overlap of these ranges, although the area may still be 0 if
#             there is no \y-axis overlap as well.
# 
#             Which leads us to th e\t-axis next. It is the combination of
#             these four overlaped ranges that in turn defines the left and
#             right, top and bottom extremities of the intersected area.
# 
#             So we get that shape, subtract it from the sum of the two
#             rectangles, ad we have our answer.
# 
#         method:
# 
#             We're going to go with the subtractive solution outlined
#             above. Let's call the area of one rectangle A, the other B.
#             Then we're looking for the union of the two areas:
# 
#               A ∪ B = A + B - ( A ∩ B )
# 
            
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



## a rectangle is defined as two point tuples [$p1,$p2] for the 
## bottom-left and upper-right vertices
## main functions return returns units²

sub area ( $rect ) { 
    my $x = abs( $rect->[0][0] - $rect->[1][0] );
    my $y = abs( $rect->[0][1] - $rect->[1][1] );
    return $x * $y;
}

sub intersect ( $rect1, $rect2 ) {
    _overlap( [ map { $_->[0] } $rect1->@* ],       ## rect 1 x-axis
              [ map { $_->[0] } $rect2->@* ] )      ## rect 2 x-axis
        * 
    _overlap( [ map { $_->[1] } $rect1->@* ],       ## rect 1 y-axis
              [ map { $_->[1] } $rect2->@* ] );     ## rect 2 y-axis
}

sub union ( $rect1, $rect2 ) {
      area ($rect1)  
    + area ($rect2)  
    - intersect ($rect1, $rect2) ;
}

sub _overlap ( $r1, $r2 ) {
## ranges are ordered 2-element tuples [start,end] : end > start
## no order is assumed between the two ranges $r1 and $r2
## returns absolute value of overlapping range
## there are five cases total:
##  1.  no overlap
##  2.  A overlaps start of B
##  3.  B overlaps start of A
##  4.  A completely encloses B
##  5.  B completely encloses A

    ## sort the ranges by start point (merge cases 2+3 and 4+5)
    $r1->[0] > $r2->[0] and ( $r1, $r2 ) = ( $r2, $r1 );

    $r2->[0] > $r1->[1] 
        ? 0                             ## no overlap (1)
        : abs( $r2->[0] 
            - ( $r2->[1] > $r1->[1]  
                ? $r1->[1]              ## intersection (2+3)
                : $r2->[1] )  )         ## A encloses B (4+5)
}



use Test::More;

is union( [[-1,0],  [2,2]], [[0,-1],  [4,4]] ), 22, 'ex-1';
is union( [[-3,-1], [1,3]], [[-1,-3], [2,2]] ), 25, 'ex-2';
is union( [[-2,-2], [0,0]], [[0,0], [2,2]] ), 8, 'figure-8, no overlap';
is union( [[0,0], [2,2]],   [[0,0], [2,2]] ), 4, 'superimposed, all overlap';

is union( [[0,0], [2,4]],   [[0,0], [3,4]] ), 12, 'A in B, left-aligned';
is union( [[0,0], [3,4]],   [[0,0], [2,4]] ), 12, 'B in A, left-aligned';
is union( [[1,0], [3,4]],   [[0,0], [3,4]] ), 12, 'A in B, right-aligned';
is union( [[0,0], [3,4]],   [[1,0], [3,4]] ), 12, 'B in A, right-aligned';


done_testing();
