#!/usr/bin/env perl

##################################################
#     Perl Weekle Challenge 040 -> Chapter 1     #
##################################################

use v5.10;
use strict;
use warnings;

my @arr1 = qw( I L O V E Y O U );
my @arr2 = qw( T Z U Y U F R O M);
my @arr3 = qw( T W I C E );
my @arr4 = qw( ! ? £ $ % ^ & * );

&print_arrays(\@arr1, \@arr2, \@arr3, \@arr4);

sub print_arrays {
    my $max_size = 0;
    for (@_) {
        my $size = scalar @$_;
        $max_size = $size if $size > $max_size;
    }

    for my $i (0 .. $max_size) {
        for (@_) {
            if ($_->[$i]) { print $_->[$i] . ' ' }
            else { print '  ' };
        }
        print "\n";
    }
}
