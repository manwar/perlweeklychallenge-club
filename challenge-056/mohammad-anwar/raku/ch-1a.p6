#!/usr/bin/env perl6

use Test;

my $unit-tests = :{
    2 => {
        in  => ( 10, 8, 7, 6, 1 ),
        out => [ " 0, 1 => (10 -  8) => 2",
                 " 1, 3 => ( 8 -  6) => 2" ]
    },
    3 => {
        in  => ( 20, 15, 14, 10, 7, 6, 4, 1 ),
        out => [ " 3, 4 => (10 -  7) => 3",
                 " 4, 6 => ( 7 -  4) => 3",
                 " 6, 7 => ( 4 -  1) => 3"]
    },
    4 => {
        in  => ( 50, 40, 30, 20, 10 ),
        out => [ ]
    },
};

for $unit-tests.keys -> $K {
    # contributed by @smokemachine
    my @L = $unit-tests{$K}<in><>;
    # same as above, contributed by @khaledelboray
    # my @L = $unit-tests{$K}<in>.Slip;
    my $R = $unit-tests{$K}<out>;

    is-deeply(find-match($K, @L), $R, "testing with K=$K");
}

done-testing;

sub find-match(Int $K, @L where .all ~~ Int) {
    my $matched = [];
    my $S = @L.elems;
    my $fmt = "%2s,%2s => (%2s - %2s) => %d";
    for 0 .. --$S -> $i {
        for $i+1 .. $S -> $j {
            my $k = @L[$i] - @L[$j];
            if $k == $K {
                $matched.push: sprintf($fmt, $i, $j, @L[$i], @L[$j], $k);
            }
        }
    }

    return $matched;
}
