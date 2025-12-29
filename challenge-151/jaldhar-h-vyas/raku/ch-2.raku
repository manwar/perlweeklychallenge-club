#!/usr/bin/raku

sub MAIN(
    *@valuables
 ) {
    my @dp = 0, @valuables[0];

    for 1 .. @valuables.end {
        @dp.push(@dp[*-1] max (@dp[*-2] + @valuables[$_]));
    }

    say @dp[*-1];
}