#!/usr/bin/env raku

sub reshape-matrix (+@matrix, :$c!,:$r!) {
    CATCH { default { warn $_ } }
    @matrix[*;*]
    andthen .batch($c)
    andthen Array.new: $_, :shape($r;$c)\
    andthen .[$r-1;$c-1] ?? $_ !! Nil
}

multi MAIN (Bool :test($)!) {
    use Test;
    CONTROL {
        default {
            like $_, /:s out of range/;
            .resume
        }
    }
    is-deeply reshape-matrix([ [ 1, 2 ], [ 3, 4 ] ]):1r:4c, Array.new: [[ 1, 2, 3, 4 ],], :shape(1,4);
    is-deeply reshape-matrix([ 1, 2, 3 ] , [ 4, 5, 6 ]):3r:2c,  Array.new: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ], :shape(3,2);
    is-deeply reshape-matrix([ [ 1, 2 ], ]):3r:2c, Nil;
    is-deeply reshape-matrix([ [ 1, 2 ], ]):1r:1c, Nil;
    done-testing;
}

multi MAIN (*@matrix, UInt :$r!, UInt :$c!) {
    say  reshape-matrix(@matrix):$r:$c // 0
}
