#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [1, 2, 4, 5, 6], out => 7 },
    { in => [-5, -2, -1, 3], out => 1 },
    { in => [1, 2, 3],       out => 4 },
    { in => [2, 3, 7, 8],    out => 6 },
    { in => [1, 1, 1, 10],   out => 4 },
);

for @examples {
    is smallest-greater-absent(|$_<in>), $_<out>;
}

done-testing;

sub smallest-greater-absent(*@arr) {
    my %seen = @arr.map({ $_ => True });
    my $avg  = @arr.sum / @arr.elems;
    my $n    = $avg.Int + 1;
    $n = 1 if $n < 1;
    $n++ while %seen{$n};
    return $n;
}
