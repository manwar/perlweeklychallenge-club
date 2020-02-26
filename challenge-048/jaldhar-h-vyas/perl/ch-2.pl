#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @years =
    grep {
        / (?<year> \d\d) $ /gmx;
        grep { $_ == $+{year}} (10, 20, 30, 40, 50, 60 , 70, 80, 90, 1, 11, 21) 
    } (2000 .. 2999);

for my $year (@years) {
    (reverse $year) =~ / \A (?<month> \d\d) (?<day> \d\d) \z /gmx;

    if ($+{day} < 23) {
        say join q{/}, ($+{month}, $+{day}, $year);
    }
}
