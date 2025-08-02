#!/usr/bin/env raku
use v6.e.*;

sub triple-to-ranges ( + ($interval, $offset, $duration), :$long = 60 ) {
    $offset..($offset+$duration), * + $interval ... *.min ≥ $long
}

sub bus-route (+buses) {
    ^60 .grep: { should-leave($_, buses.map: &triple-to-ranges) }
}

sub should-leave ( $time, +buses-range ) {
    buses-range
    andthen .map: *.first: $time ≤ *.min
    andthen .cache
    andthen .min( *.min, :k).any == .min(*.max, :k).any
    andthen .not
}

multi MAIN (Bool :test($)!) {
    use Test;
    my $bus-a = triple-to-ranges(12,11,41);
    my $bus-b = triple-to-ranges(15, 5,35);
    is-deeply $bus-a, (11..52, 23..64, 35..76, 47..88, 59..100, 71..112);
    is-deeply $bus-b, (5..40, 20..55, 35..70, 50..85, 65..100);
    is should-leave(30, ($bus-a, $bus-b)), False;
    is should-leave(36, ($bus-a, $bus-b)), True;
    is bus-route([12, 11, 41], [15, 5, 35]), (36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47);
    is bus-route([12, 3, 41], [15, 9, 35], [30, 5, 25]), ( 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59);
    is bus-route([12, 3, 41], [15, 8, 35], [3, 2, 25]), ( 3,15,27,39,51 );
    done-testing;
}


 multi MAIN (+buses) {
     buses
     andthen .map: *.comb( / \d+ /)».Int
     andthen bus-route .cache
     andthen .put
}
