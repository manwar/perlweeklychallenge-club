#!/usr/bin/env raku

use Test;

is rectangle-area((-1,0),  (2,2), (0,-1),  (4,4)), 22;
is rectangle-area((-3,-1), (1,3), (-1,-3), (2,2)), 25;  
is rectangle-area((1,1),   (2,2), (3,3),   (4,4)), 2;  

sub rectangle-area($bl_1, $tr_1, $bl_2, $tr_2)
{
    my $area_1 = abs($bl_1[0] - $tr_1[0]) * abs($bl_1[1] - $tr_1[1]);
    my $area_2 = abs($bl_2[0] - $tr_2[0]) * abs($bl_2[1] - $tr_2[1]);

    my $int_bl_x = max($bl_1[0], $bl_2[0]);
    my $int_tr_x = min($tr_1[0], $tr_2[0]);
    my $int_bl_y = max($bl_1[1], $bl_2[1]);
    my $int_tr_y = min($tr_1[1], $tr_2[1]);

    my $int_x_dist = $int_tr_x - $int_bl_x;
    my $int_y_dist = $int_tr_y - $int_bl_y;

    my $area_int = $int_x_dist|$int_y_dist < 0 ?? 0 !! $int_x_dist*$int_y_dist;
    
    return $area_1 + $area_2 - $area_int;
}
