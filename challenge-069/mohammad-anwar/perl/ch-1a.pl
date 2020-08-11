#!/usr/bin/perl

#
# Perl Weekly Challenge - 069
#
# Task #1: Strobogrammatic Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069
#

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( [ strobogrammatic_numbers(50, 100) ],
           [ 69, 88, 96 ],
           'testing A=50, B = 100' );

done_testing;

sub strobogrammatic_numbers {
    my ($start, $stop) = @_;

    die "ERROR: Missing start number.\n"
        unless defined $start;
    die "ERROR: Missing stop  number.\n"
        unless defined $stop;
    die "ERROR: Invalid start number [$start].\n"
        unless ($start >= 1);
    die "ERROR: Invalid end number [$stop].\n"
        unless ($stop >= 1);
    die "ERROR: Invalid start number [$start].\n"
        unless ($start < $stop);

    my %digits = (6 => 9, 8 => 8, 9 => 6);

    my @strobogrammatic = ();
    foreach my $n ($start .. $stop) {
        next if ($n < 10);

        my $found = 1;
        my @match = ();
        foreach my $i (split //, $n) {
            if (exists $digits{$i}) {
                push @match, $digits{$i};
            }
            else {
                $found = 0;
                last;
            }
        }

        if ($found) {
            push @strobogrammatic, $n
                if ($n == join('', reverse @match));
        }
    }

    return @strobogrammatic;
}
