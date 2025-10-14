#!/usr/bin/env raku

use Test;

my @examples = (
    { input => [4, 2, -1, 3, -2],     exp => 1 },
    { input => [-5, 5, -3, 3, -1, 1], exp => 1 },
    { input => [7, -3, 0, 2, -8],     exp => 0 },
    { input => [-2, -5, -1, -8],      exp => 1 },
    { input => [-2, 2, -4, 4, -1, 1], exp => 1 },
);

for @examples -> %example {
    is(zero_friend(%example<input>), %example<exp>);
}

done-testing;

sub zero_friend($nums) { return min $nums.map(&abs); }
