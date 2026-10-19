#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [1,3,5,4,2,6,8],    out => 'true'  },
    { in => [1,4,4,2,1,3,5],    out => 'false' },
    { in => [2,10,3,1,9],       out => 'true'  },
    { in => [1,2,3,4,3,2,1],    out => 'false' },
    { in => [1,3,6,4,2,7,8,4],  out => 'false' },
);

for @examples -> $ex {
    is trionic(|$ex<in>), $ex<out>;
}

done-testing;

sub trionic(*@arr) {
    my $n = @arr.elems;
    return 'false' if $n < 4;

    my $i = 0;
    $i++ while $i < $n - 1 && @arr[$i] < @arr[$i + 1];
    my $p = $i;
    return 'false' if $p == 0;

    $i++ while $i < $n - 1 && @arr[$i] > @arr[$i + 1];
    my $q = $i;

    return 'false' if $q == $p || $q >= $n - 1;

    $i++ while $i < $n - 1 && @arr[$i] < @arr[$i + 1];

    return $i == $n - 1 ?? 'true' !! 'false';
}
