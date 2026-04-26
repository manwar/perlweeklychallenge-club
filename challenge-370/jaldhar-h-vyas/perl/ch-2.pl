#!/usr/bin/perl
use 5.40.1;
use warnings;

sub isScramble($str1, $str2) {

    if ($str1 eq $str2) {
        return true;
    }

    my $n = length $str1;
    for my $i (1 .. $n - 1) {
        my $str1A = substr $str1, 0, $i;
        my $str1B = substr $str1, $i, $n - $i;

        my $str2A = substr $str2, 0, $i;
        my $str2B = substr $str2, $i, $n - $i;

        if (isScramble($str1A, $str2A) && isScramble($str1B, $str2B)) {
            return true;
        }

        my $str2AS = substr $str2, $n - $i, $i;
        my $str2BS = substr $str2, 0, $n - $i;

        if (isScramble($str1A, $str2AS) && isScramble($str1B, $str2BS)) {
            return true;
        }
    }

    return false;
}

my ($str1, $str2) = @ARGV;

if (length($str1) != length($str2) ||
join(q{}, sort split //, $str1) ne join(q{}, sort split //, $str2)) {
    say "false";
} else {
    say isScramble($str1, $str2) ? "true" : "false";
}
