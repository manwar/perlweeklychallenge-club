#!/usr/bin/perl
use strict;
use warnings;

sub merge_strings {
    my ($aref, $bref) = @_;

    my @a = @$aref;
    my @b = @$bref;
    my $min = @a < @b ? @a : @b;

    my @result;
    push @result, $a[$_], $b[$_] for 0 .. $min - 1;
    push @result, @a[$min .. $#a], @b[$min .. $#b];

    return @result;
}

# Tests

my (@a, @b);

# Example 1
@a = qw/a b c/;
@b = qw/1 2 3/;
print join('', merge_strings(\@a, \@b)), "\n"; # Output: a1b2c3

# Example 1
@a = qw/a b c d e/;
@b = qw/1 2 3/;
print join('', merge_strings(\@a, \@b)), "\n"; # Output: a1b2c3de

# Example 1
@a = qw/a b c/;
@b = qw/1 2 3 4 5/;
print join('', merge_strings(\@a, \@b)), "\n"; # Output: a1b2c345
