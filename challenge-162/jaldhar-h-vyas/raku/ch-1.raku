#!/usr/bin/raku

sub MAIN (
    Str $isbn where { /(\d ** 3) \- (\d) \- (\d ** 3) \- (\d ** 5) \- (\d) /} #= An ISBN in the format nnn-n-nnn-nnnnn-n
) {
    my @digits = $/.list.join(q{}).comb;
    my @multipliers = (1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3);

    my $checkdigit = 10 - ([+] (@digits[0 .. 11] Z* @multipliers)) % 10;
    say $checkdigit, ($checkdigit == @digits[12] ?? ' (valid)' !! ' (invalid)');
}