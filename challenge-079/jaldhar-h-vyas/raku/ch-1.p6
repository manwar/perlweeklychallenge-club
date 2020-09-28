#!/usr/bin/perl6

sub MAIN(
    Int $N where { $N > 0 } #= positive integer
) {
    my $total = [+] (1 .. $N).map({ sprintf("%b", $_) ~~ m:g/ 1 /; });

    say "$total % 1000000007 = $total";
}