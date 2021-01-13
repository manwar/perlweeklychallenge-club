#!/usr/bin/perl6

multi sub MAIN(
    Int $N, #= number of digits in match
    Int $S  #= sum of digits in match
) {
    ([X~] ([0 .. 9] xx $N))
        .grep({ !/^0/ })
        .grep({ ([+] $_.comb) == $S })
        .join(q{, })
        .say;
}