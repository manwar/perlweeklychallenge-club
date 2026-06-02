#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [ "a7", "f4" ], out => "true"  },
    { in => [ "c1", "a8" ], out => "false" },
    { in => [ "b5", "h2" ], out => "false" },
    { in => [ "f3", "h1" ], out => "true"  },
    { in => [ "a1", "g8" ], out => "false" },
);

for @examples -> $_ {
    is same_color(|@($_<in>)), $_<out>;
}

done-testing;

sub same_color($c1, $c2) {
    my $sum1 = ($c1.substr(0, 1).ord - 97) + $c1.substr(1);
    my $sum2 = ($c2.substr(0, 1).ord - 97) + $c2.substr(1);

    return ($sum1 % 2) == ($sum2 % 2) ?? "true" !! "false";
}
