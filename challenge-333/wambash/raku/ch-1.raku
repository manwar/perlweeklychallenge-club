#!/usr/bin/env raku

sub straight-line (+@list) {
    my ($M, $N) = @list.squish( with => &[eqv] );
    return True without $N;

    my $a=$M[0]-$N[0];
    my $b=$M[1]-$N[1];

    @list
    andthen .map: {$b * .[0] - $a * .[1]}\
    andthen  [==] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is straight-line((2,1),(2,3),(2,5)), True;
    is straight-line((1,4),(3,4),(10,4)), True;
    is straight-line((0,0),(1,1),(2,3)), False;
    is straight-line((1,1),(2,2),(3,3)), True;
    is straight-line((1,1),(1,1),(1,1)), True;
    is straight-line((1,1),(1,1),(2,2),(3,4)), False;
    is straight-line((1_000_000,1_000_000),(2_000_000,2_000_000),(3_000_000,3_000_000)), True;
    done-testing;
}

multi MAIN (+list) {
    say straight-line  list.map: *.split(',').cache;
}
