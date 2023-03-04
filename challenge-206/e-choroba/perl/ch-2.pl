#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub array_pairings(@arr) {
    my $i = 0;
    return sum(grep ++$i % 2, sort { $a <=> $b } @arr)
}

sub array_pairings_slow(@arr) {
    my $s = 0;
    for my $i (0 .. $#arr) {
        for my $j (0 .. $#arr) {
            next if $i == $j;

            my $c = $arr[ $arr[$i] < $arr[$j] ? $i : $j ]
                + array_pairings(@arr[grep $_ != $i && $_ != $j, 0 .. $#arr]);
            $s = $c if $c > $s;
        }
    }
    return $s
}

use Test::More tests => 2 + 2 + 20;

is array_pairings(1, 2, 3, 4), 4, 'Example 1';
is array_pairings(0, 2, 1, 3), 2, 'Example 2';

is array_pairings_slow(1, 2, 3, 4), 4, 'Slow example 1';
is array_pairings_slow(0, 2, 1, 3), 2, 'Slow example 2';

for (1 .. 20) {
    my @arr = map int rand 20, 1 .. 10;
    is array_pairings(@arr), array_pairings_slow(@arr), "Random @arr";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    slow => sub { array_pairings_slow(1 .. 8) },
    fast => sub { array_pairings(1 .. 8) },
});

__END__
         Rate  slow  fast
slow   7197/s    --  -99%
fast 649241/s 8921%    --
