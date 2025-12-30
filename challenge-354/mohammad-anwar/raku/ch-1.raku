#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [4, 2, 1, 3],      out => [[1, 2], [2, 3], [3, 4]] },
    { in => [10, 100, 20, 30], out => [[10, 20], [20, 30]]     },
    { in => [-5, -2, 0, 3],    out => [[-2, 0]]                },
    { in => [8, 1, 15, 3],     out => [[1, 3]]                 },
    { in => [12, 5, 9, 1, 15], out => [[9, 12], [12, 15]]      },
);

for @examples -> $example {
    is-deeply min-abs-diff($example<in>), $example<out>;
}

done-testing;

sub min-abs-diff(@ints) {
    my @a = @ints.sort: { $^a <=> $^b };
    my $m = 9**9;

    for 0 .. @a.end - 1 -> $i {
        my $diff = @a[$i+1] - @a[$i];
        if $diff < $m {
            $m = $diff;
        }
    }

    my @pairs = (0 .. @a.end - 1)
        .grep({ @a[$_+1] - @a[$_] == $m })
        .map({ [ @a[$_], @a[$_+1] ] });

    return @pairs == 1 ?? @pairs[0] !! @pairs;
}
