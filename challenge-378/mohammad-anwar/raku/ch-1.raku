#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => "aaaaa77777",         out => -1 },
    { in  => "abcde",              out => -1 },
    { in  => "9zero8eight7seven9", out => 8  },
    { in  => "xyz9876543210",      out => 8  },
    { in  => "4abc4def2ghi8jkl2",  out => 4  },
);

for @examples {
    is second_largest_digit($_<in>), $_<out>;
}

done-testing;

sub second_largest_digit($str) {
    my @digits = $str.comb(/\d/);
    my @sorted_digits = @digits.unique.sort.reverse;

    return @sorted_digits < 2 ?? -1 !! @sorted_digits[1];
}
