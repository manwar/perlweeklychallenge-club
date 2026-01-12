#!/usr/bin/env raku

use Test;

my @examples = (
    { in => 4, out => 2 },
    { in => 5, out => 3 },
    { in => 6, out => 3 },
    { in => 7, out => 4 },
    { in => 8, out => 4 },
);

is count_one( .<in> ), .<out> for @examples;

done-testing;

sub count_one($n) {
    my @k = 1, 2, 2;
    my $i = 2;

    @k.push: |((@k[*-1] +^ 3) xx @k[$i++]) while @k < $n;
    my $s = join("", @k[0..$n-1]);

    return +($s ~~ tr/1//);
}
