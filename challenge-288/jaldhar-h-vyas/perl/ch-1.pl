#!/usr/bin/perl
use v5.38;

sub isPalindrome($str) {
    return $str eq reverse $str;
}

my $str = shift;
my $lower = $str - 1;
my $upper = $str + 1;

while (1) {
    if (isPalindrome($lower)) {
        say $lower;
        last;
    }
    if (isPalindrome($upper)) {
        say $upper;
        last;
    }
    $lower--;
    $upper++;
}
