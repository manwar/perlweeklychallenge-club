#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["abc",  1], out => 6},
    { in => ["az",   2], out => 9},
    { in => ["cat",  1], out => 6},
    { in => ["dog",  2], out => 8},
    { in => ["perl", 3], out => 6},
);

for @examples -> %example {
    is alphabet-index-digit-sum(%example<in>), %example<out>;
}

done-testing;

sub alphabet-index-digit-sum (@args) {
    my ($s, $k) = @args;

    my $n = join "", map { $_.ord - 96 }, $s.comb;
    $n = [+] $n.comb for 1..$k;
    return $n;
}
