#!/usr/bin/perl
use strict;
use warnings;

sub esthetic_number {
    my ($str) = @_;
    die "Invalid string: contains non-digit characters\n" unless $str =~ /^[0-9]+$/;

    my @arr = split //, $str;

    for my $i (0 .. $#arr - 1) {
        return 0 if abs($arr[$i] - $arr[$i+1]) != 1;
    }
    return 1;
}

sub esthetic_number_alt {
    my ($str) = @_;

    die "Invalid string: contains non-digit characters\n" unless $str =~ /^[0-9]+$/;

    # !grep {...} LIST  gives True if NO elements match the condition
    # here: ensures no adjacent digits violate |difference| == 1

    !grep { abs(substr($str,$_,1) - substr($str,$_+1,1)) != 1 } 0..length($str)-2
}

# Tests

my $str;

# Example 1
$str = "5456";
print esthetic_number($str), "\n";# Output: 1

# Example 2
$str = "120";
print esthetic_number($str), "\n";# Output: 0
