#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any first sum0);
use Scalar::Util qw(looks_like_number);

use Pod::Usage;

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, 'lib' );

use Combinations qw(combinations);

pod2usage(
    -message => "$0: Expects a list of positive numbers",
    -exitval => 1,
) if !@ARGV || any { !looks_like_number($_) || $_ < 1 } @ARGV;

say flip_array(@ARGV);

sub flip_array(@numbers) {
    my $sum     = sum0(@numbers);
    my $ceiling = int( $sum / 2 );

    for my $target ( reverse( 0 .. $ceiling ) ) {
        my $count = first(
            sub {
                any { sum0(@$_) eq $target } combinations( $_, @numbers );
            },
            1 .. @numbers
        );

        return $count if $count;
    }

    return 0;
}

=pod

=head1 NAME

wk-083 ch-2 - Flip Array

=head1 SYNOPSIS

You are given an array @A of positive numbers.

Write a script to flip the sign of some members of the given array so that the sum of the all members is minimum non-negative.

Given an array of positive elements, you have to flip the sign of some of its elements such that the resultant sum of the elements of array should be minimum non-negative(as close to zero as possible). Return the minimum no. of elements whose sign needs to be flipped such that the resultant sum is minimum non-negative.

ch-2.pl <A> <A> ...

=head1 ARGUMENTS

=over 8

=item B<A> a list of positive numbers

=back

=cut
