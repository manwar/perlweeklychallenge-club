#!/usr/bin/perl
use strict;
use warnings;

sub is_valid_permutation {
    my ($indices, $n) = @_;

    return 0 unless @$indices == $n;

    my @sorted = sort { $a <=> $b } @$indices;

    for my $i (0 .. $#sorted) {
        return 0 if $sorted[$i] != $i;
    }

    return 1;
}

sub shuffle_string {

    my ($str, $indices) = @_;

    die "Length mismatch" unless length($str) == @$indices;

    for my $i (@$indices) {
        die "Invalid indicesex $i" if $i < 0 || $i >= length($str);
    }

    die "Invalid indicesices"
        unless is_valid_permutation($indices, length($str));

    my $new_str = "-" x length($str);

    for (my $i=0; $i < scalar(@$indices); $i++) { # or: for my $i (0 .. @$indices - 1) {
        substr($new_str, $indices->[$i], 1) = substr($str, $i, 1);
    }

    return $new_str;
}

# Tests
my $str;
my @indices;

# Example 1
$str = 'lacelengh';
@indices = (3,2,0,5,4,8,6,7,1);
print shuffle_string($str, \@indices), "\n"; # Output: challenge

# Example 2
$str = 'rulepark';
@indices = (4,7,3,1,0,5,2,6);
print shuffle_string($str, \@indices), "\n"; # Output: perlraku
