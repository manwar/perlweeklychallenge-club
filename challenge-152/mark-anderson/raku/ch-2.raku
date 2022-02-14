#!/usr/bin/env raku

use Test;

is rectangle-area((-1,0),  (2,2),   (0,-1),  (4,4)),   22;
is rectangle-area((-3,-1), (1,3),   (-1,-3), (2,2)),   25;  
is rectangle-area((1,1),   (2,2),   (3,3),   (4,4)),   2;  
is rectangle-area((-1,-1), (-2,-2), (1,1),   (2,2)),   2;  
is rectangle-area((1,1),   (2,2),   (-1,-1), (-2,-2)), 2;  
is rectangle-area((3,3),   (4,4),   (1,1),   (2,2)),   2;  
is rectangle-area((4,2),   (7,5),   (2,3),   (5,7)),   19;

sub rectangle-area(+@p)
{
    my $p = @p.map(|*);
    
    my $int = flat ($p[0,4], $p[1,5])>>.max, ($p[2,6], $p[3,7])>>.min;

    my $int-x = [-] $int[2,0];
    my $int-y = [-] $int[3,1];
 
    my $int-area = $int-x|$int-y < 0 ?? 0 !! $int-x * $int-y;

    ([-] $p[0,2]) * ([-] $p[1,3]) + ([-] $p[4,6]) * ([-] $p[5,7]) - $int-area;
}
