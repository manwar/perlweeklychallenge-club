#!/usr/bin/env perl6
#
#
#       avon-calling.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @mat =   [0, 5, 2, 7],
            [5, 0, 5, 3],
            [3, 1, 0, 6],
            [4, 5, 4, 0];

my $dist;
my @sp;
my $min = ∞ ;

for (1..@mat.elems-1).permutations -> @p {

    $dist = @mat[0][ @p[0] ];         ## start leg
    
    for 0..@p.elems-2 -> $i {         ## city-to-city
        $dist += @mat[ @p[$i] ][ @p[$i+1] ];
    }
    
    $dist += @mat[ @p[*-1] ][ 0 ];    ## return leg

    if $dist < $min {
        @sp  = @p;
        $min = $dist;
    }
}

say $_ for @mat;
say '';
say "shortest path $min";
say "path: ", (0, |@sp, 0).join: ' → '
