#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [8000, 5000, 6000, 2000, 3000, 7000], out => 5250   },
    { in => [100_000, 80_000, 110_000, 90_000],   out => 95_000 },
    { in => [2500, 2500, 2500, 2500],             out => 0      },
    { in => [2000],                               out => 0      },
    { in => [1000, 2000, 3000, 4000, 5000, 6000], out => 3500   },
);

is(special-average(|$_{'in'}), $_{'out'}) for @examples;

done-testing;

sub special-average(*@nums) {
    return 0 unless @nums.elems;

    my $min = @nums.min;
    my $max = @nums.max;

    my @filtered = @nums.grep: { $_ != $min && $_ != $max };
    return 0 unless @filtered.elems;

    my $sum = [+] @filtered;

    return $sum / @filtered.elems;
}
