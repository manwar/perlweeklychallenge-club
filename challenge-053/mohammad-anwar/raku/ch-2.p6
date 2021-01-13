#!/usr/bin/env perl6

use v6.c;

sub MAIN(Int $count = 2) {
    die "ERROR: Invalid count $count.\n"
        unless $count ~~ any (1, 2, 3, 4, 5);

    my @chars = <a e i o u>;

    if $count == 1 {
        say @chars.join("\n");
        exit;
    }

    my @char-sets = @chars.combinations: $count;
    my @comb-sets = @char-sets.map({ .join });

    my @rules = (
        rx/ a<[ie]>   /,
        rx/ e<[i]>    /,
        rx/ i<[aeou]> /,
        rx/ o<[au]>   /,
        rx/ u<[oe]>   /,
    );

    for @comb-sets -> $str {
        my $pass = False;
        for @rules -> $rule {
            if $str ~~ /$rule/ {
                $pass = True;
            }
        }
        say $str if $pass;
    }
}
