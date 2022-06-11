#!/usr/bin/env perl

# Challenge 060
#
# TASK #1 › Excel Column
# Reviewed by: Ryan Thompson
# Write a script that accepts a number and returns the Excel Column Name it
# represents and vice-versa.
#
# Excel columns start at A and increase lexicographically using the 26 letters
# of the English alphabet, A..Z. After Z, the columns pick up an extra “digit”,
# going from AA, AB, etc., which could (in theory) continue to an arbitrary
# number of digits. In practice, Excel sheets are limited to 16,384 columns.
#
# Example
# Input Number: 28
# Output: AB
#
# Input Column Name: AD
# Output: 30

use Modern::Perl;

my $arg = shift||"";
if ($arg =~ /^\d+$/) {
    say num2col($arg);
}
elsif ($arg =~ /^[A-Z]+$/) {
    say col2num($arg);
}
else {
    die "invalid column: $arg\n";
}

sub col2num {
    my($col) = @_;
    my $num = 0;
    for my $digit (split //, uc($col)) {
        $num = $num*26 + ord($digit) - ord('A') + 1;
    }
    return $num;
}

sub num2col {
    my($num) = @_;
    my $col = "";
    while ($num > 0) {
        my $digit = ($num-1) % 26;
        $num = int(($num-1) / 26);
        $col = chr(ord('A') + $digit).$col;
    }
    return $col;
}
