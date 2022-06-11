#!/usr/bin/env perl6
#
#
#       whos-masking-the-mask.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

sub area ( @rect ) {

    ((@rect[0][0] - @rect[1][0]) * (@rect[0][1] - @rect[1][1])).abs
}

sub intersect ( @rect1, @rect2 ) {

    _overlap( @rect1.map(*[0]),       ## rect 1 x-axis
              @rect2.map(*[0]) )      ## rect 2 x-axis
              
        * 
        
    _overlap( @rect1.map(*[1]),       ## rect 1 y-axis
              @rect2.map(*[1]) );     ## rect 2 y-axis
}

sub union ( @rect1, @rect2 ) {

      area(@rect1)  
    + area(@rect2)  
    - intersect(@rect1, @rect2) ;
}

sub _overlap ( $r1 is copy, $r2 is copy ) {

    ## sort the ranges by start point (merge cases 2+3 and 4+5)
    $r1[0] > $r2[0] and ($r1, $r2) = ($r2, $r1) ;
        
    $r2[0] > $r1[1] 
        ?? 0                           ## no overlap (1)
        !! abs( $r2[0] 
            - ( $r2[1] > $r1[1]  
                ?? $r1[1]              ## intersection (2+3)
                !! $r2[1] )  )         ## A encloses B (4+5)
}


use Test;

is union( ((-1,0),(2,2) ), ((0,-1),(4,4)) )     , 22,   'ex-1';
is union( ((-3,-1), (1,3)), ((-1,-3), (2,2)) )  , 25,   'ex-2';
is union( ((-2,-2), (0,0)), ((1,1), (3,3)) )    , 8,    'independant, no overlap';
is union( ((-2,-2), (0,0)), ((0,0), (2,2)) )    , 8,    'figure-8, single point overlap';
is union( ((0,-2), (2,0)), ((0,0), (2,2)) )     , 8,    'stacked, single line overlap';
is union( ((0,-2), (2,1)), ((0,-1), (2,2)) )    , 8,    'stacked, overlapped';
is union( ((0,0), (2,2)),   ((0,0), (2,2)) )    , 4,    'superimposed, all overlap';


is union( ((0,0), (2,4)),   ((0,0), (3,4)) ), 12, 'A in B, left-aligned';
is union( ((0,0), (3,4)),   ((0,0), (2,4)) ), 12, 'B in A, left-aligned';
is union( ((1,0), (3,4)),   ((0,0), (3,4)) ), 12, 'A in B, right-aligned';
is union( ((0,0), (3,4)),   ((1,0), (3,4)) ), 12, 'B in A, right-aligned';


