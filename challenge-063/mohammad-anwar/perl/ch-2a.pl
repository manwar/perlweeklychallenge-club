#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is (rotate('xyxx'), 7, 'xyxx');
is (rotate('xyxy'), 3, 'xyxy');

done_testing;

sub rotate {
    my ($string, $verbose) = @_;

    die "ERROR: Missing string.\n"
        unless defined $string;
    die "ERROR: Invalid string [$string].\n"
        unless ($string =~ /^[xy]+$/i);

    my $size = length($string);
    my $temp = $string;
    my $i = 1;
    my $c = 1;
    while ($i <= $size) {
        my $part_a = substr($temp, 0, $i);
        my $part_b = substr($temp, $i);
        $temp = sprintf("%s%s", $part_b, $part_a);
        print "[$c]: [$temp]\n" if ($verbose);
        last if ($temp eq $string);

        $i++; $c++;
        $i = 1 if ($i > $size);
    }

    return $c;
}
