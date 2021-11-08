#!/usr/bin/env perl

# TASK #2 > Validate SEDOL
# Submitted by: Mohammad S Anwar
# You are given 7-characters alphanumeric SEDOL.
#
# Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL
# otherwise 0.
#
# For more information about SEDOL, please checkout the wikipedia page.
#
# Example 1
# Input: $SEDOL = '2936921'
# Output: 1
# Example 2
# Input: $SEDOL = '1234567'
# Output: 0
# Example 3
# Input: $SEDOL = 'B0YBKL9'
# Output: 1

use Modern::Perl;

my $SEDOL = shift||"";
say check_sedol($SEDOL);

sub check_sedol {
    my($str) = @_;
    return 0 unless $str =~ /^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$/;
    my $input = substr($str, 0, 6);
    my $check_digit = compute_check_digit($input);
    if ($input.$check_digit eq $str) {
        return 1;
    }
    else {
        return 0;
    }
}

sub compute_check_digit {
    my($input) = @_;
    my @weight = (1, 3, 1, 7, 3, 9);
    my @input = map {$_ ge 'A' ? ord($_)-ord('A')+10 : ord($_)-ord('0')}
                split //, $input;
    my $sum = 0;
    for my $i (0..$#weight) {
        $sum += $input[$i] * $weight[$i];
    }
    return (10-$sum%10);
}
