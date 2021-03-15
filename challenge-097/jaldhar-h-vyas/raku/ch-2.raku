#!/usr/bin/raku

sub MAIN(
    Str $B, #= a binary string
    Int $S  #= size of substrings
) {
    my @substrings = $B.comb($S.Int).map({ $_.parse-base(2); });
    my $template = @substrings.shift;

    say [+] @substrings.map({ sprintf("%b", $template +^ $_) ~~ m:g/ 1 /; });
}