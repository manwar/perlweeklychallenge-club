#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is (flip_binary("10001"), "11111 (2,4)");
is (flip_binary("10101"), "10111 (4,4) | 11011 (2,4) | 11101 (2,2)");
is (flip_binary("00101"), "11011 (1,4) | 11101 (1,2)");

done_testing;

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

    return flipped_binary($result);
}

sub flipped_binary {
    my ($result) = @_;

    my $v;
    my @r;
    foreach my $k (sort { $result->{$b} <=> $result->{$a} } sort keys %$result) {
        if (defined $v) {
            if ($result->{$k} == $v) {
                push @r, $k;
            }
        }
        else {
            $v = $result->{$k};
            push @r, $k;
        }
    }

    return join (" | ", @r);
}
