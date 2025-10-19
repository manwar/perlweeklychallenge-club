#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;

my @letters = sort grep { /[[:lower:]]/ } split //, $str;
my @digits = sort grep { /[[:digit:]]/ } split //, $str;
my $digitFirst  = scalar @digits >= scalar @letters;

if (abs(scalar @letters - scalar @digits) > 1) {
    say "";
    exit;
}

my $result = "";
my $lindex = 0;
my $dindex = 0;

while ($lindex < scalar @letters || $dindex < scalar @digits) {
    if ($digitFirst) {
        if ($dindex < scalar @digits) {
            $result .= $digits[$dindex++];
        }
        if ($lindex < scalar @letters) {
            $result .= $letters[$lindex++];
        }
    } else {
        if ($lindex < scalar @letters) {
            $result .= $letters[$lindex++];
        }
        if ($dindex < scalar @digits) {
            $result .= $digits[$dindex++];
        }
    }
}

say $result;