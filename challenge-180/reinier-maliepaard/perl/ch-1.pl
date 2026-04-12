#!/usr/bin/perl
use strict;
use warnings;

sub first_unique_char {
    my ($str) = @_;

    die "Invalid string: must contain at least one letter and only letters/spaces\n"
        unless $str =~ /^[A-Za-z ]*$/ && $str =~ /[A-Za-z]/;

    my %count;
    $count{$_}++ for split //, $str;

    for my $index (0 .. length($str) - 1) {
        my $char = substr($str, $index, 1);
        return ($char, " ",  $index) if $count{$char} == 1;
    }
    return;  # no unique character
}

# Tests

my $s;

# Example 1
$s = "Perl Weekly Challenge";
print first_unique_char($s), "\n"; # Output: P 0

# Example 2
$s = "Long Live Perl";
print first_unique_char($s), "\n"; # Output: o 1
