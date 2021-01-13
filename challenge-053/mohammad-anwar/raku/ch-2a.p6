#!/usr/bin/env perl6

use Test;

my $unit-tests = :{
    1 => ["a", "e", "i", "o", "u"],
    2 => ["ae", "ai", "ei", "io", "iu", "ou"],
    3 => ["aei", "aeo", "aeu", "aio", "aiu", "aou", "eio", "eiu", "eou", "iou"],
    4 => ["aeio", "aeiu", "aeou", "aiou", "eiou"],
    5 => ["aeiou"]
};

for $unit-tests.keys.sort -> $size {
    is-deeply(vowel-strings($size), $unit-tests{$size}, "vowel strings size $size.");
}

done-testing;

sub vowel-strings(Int $size = 2) {
    die "ERROR: Invalid size $size.\n"
        unless $size ~~ any (1, 2, 3, 4, 5);

    my @chars = <a e i o u>;
    return @chars if $size == 1;

    my @char-sets = @chars.combinations: $size;
    my @comb-sets = @char-sets.map({ .join });

    my @rules = (
        rx/ a<[ie]>   /,
        rx/ e<[i]>    /,
        rx/ i<[aeou]> /,
        rx/ o<[au]>   /,
        rx/ u<[oe]>   /,
    );

    my @vowel-strings = ();
    for @comb-sets -> $str {
        my $pass = False;
        for @rules -> $rule {
            if $str ~~ /$rule/ {
                $pass = True;
            }
        }
        @vowel-strings.push($str) if $pass;
    }

    return @vowel-strings;
}
