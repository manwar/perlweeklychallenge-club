#!/usr/bin/env raku

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
# TASK #2 › Trapped Rain Water
#
#   # raku ./ch-2.raku 2,1,4,1,2,5
#   6
#   # raku ./ch-2.raku 3,1,3,1,1,5
#   6

sub trapped-rain-water (@N) {
    my $water = 0;

    my @left-wall  = (0..@N.end()).map(-> $i { @N[0..$i].max() });
    my @right-wall = (0..@N.end()).map(-> $i { @N[$i..*].max() });

    for 0..@N.end() -> $i {
        $water += ( @left-wall[$i] - @N[$i], @right-wall[$i] - @N[$i] ).min();
    }

    return $water;
}

sub MAIN (Str $N) {
    my @N = $N.split(',');
    say trapped-rain-water(@N);
}
