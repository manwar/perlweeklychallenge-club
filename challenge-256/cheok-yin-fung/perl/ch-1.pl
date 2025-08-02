# The Weekly Challenge 256
# Task 1 Maximum Pairs
use v5.30.0;
use warnings;

sub mp {
    my @data = @_;
    my $p = 0;
    my @r_data = map {scalar reverse $_} @data;
    for my $i (0..$#data) {
        for my $j ($i+1..$#r_data) {
            $p++ if $data[$i] eq $r_data[$j];
        }
    }
    return $p;
}

use Test::More tests=>3;
ok mp("ab", "de", "ed", "bc") == 1;
ok mp("aa", "ba", "cd", "ed") == 0;
ok mp("uv", "qp", "st", "vu", "mn", "pq") == 2;
