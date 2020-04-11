#!/usr/bin/perl

use strict;
use warnings;

my $binary_str = $ARGV[0];

print "$binary_str => ", flip_binary($binary_str), "\n";

#
#
# METHOD

sub flip_binary {
    my ($binary_str) = @_;

    die "ERROR: Missing binary string.\n"
        unless defined $binary_str;
    die "ERROR: Invalid binary string [$binary_str].\n"
        unless ($binary_str =~ /^[01]+$/);

    my $result = {};
    my $size = length($binary_str);
    foreach my $left (1 .. $size) {
        foreach my $right ($left .. $size) {
            my $_binary_str = $binary_str;
            foreach my $i ($left .. $right) {
                --$i;
                my $c = substr($_binary_str, $i, 1);
                $c = ($c) ? (0) : (1);
                substr($_binary_str, $i, 1, $c);
            }
            $result->{ sprintf("%s (%s,%s)", $_binary_str, $left, $right) } = ($_binary_str =~ tr/1/1/);
        }
    }

    return [ sort { $result->{$b} <=> $result->{$a} } keys %$result ]->[0];
}
