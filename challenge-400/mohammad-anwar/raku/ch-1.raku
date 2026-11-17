#!/usr/bin/env raku

use Test;

my @examples = (
    { in => 20,    out => 2   },
    { in => 110,   out => 4   },
    { in => 500,   out => 11  },
    { in => 2026,  out => 105 },
    { in => 10000, out => 105 },
);

is max-jump($_<in>), $_<out> for @examples;

done-testing;

sub max-jump($num) {
    my @nums = grep { !($_ ~~ /(\d) .* $0/) }, 1 .. $num;
    my $max_diff = 0;

    for 1 .. @nums.end -> $i {
        my $diff = @nums[$i] - @nums[$i - 1];
        $max_diff = $diff if $diff > $max_diff;
    }

    return $max_diff;
}
