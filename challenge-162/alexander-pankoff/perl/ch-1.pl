#!/usr/bin/env perl

=pod
Task 1: ISBN-13
Submitted by: Mohammad S Anwar

Write a script to generate the check digit of given ISBN-13 code. Please refer
wikipedia for more information.  

Example

 ISBN-13 check digit for '978-0-306-40615-7' is 7.
=cut

package challenge162::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();
use List::Util qw(sum);

use lib File::Spec->catdir( $FindBin::RealBin,
    qw'.. .. .. challenge-001 alexander-pankoff perl lib' );

use My::List::Util qw(zip_with);
use My::String::Util qw(explode);

run() unless caller();

sub run() {
    my $isbn = $ARGV[0];
    say calculate_isbn13_check_digit($isbn);

}

sub calculate_isbn13_check_digit($isbn) {

    # make sure the input looks like a valid isbn number, remove spaces and
    # dashes.
    my $numbers = $isbn =~ s/-|\s//gr;
    die "Invalid input\n" if $numbers !~ /^\d+$/ || length $numbers != 12;

    # generate a list of the twelve weights.
    my @weights = ( 1, 3 ) x 6;
    my @numbers = explode($numbers);

    # mutliply each number in the isbn with its weight and get the total sum of
    # the weighted numbers
    my $weighted_sum = sum( zip_with( \&mul, \@numbers, \@weights ) );

    my $check_digit = ( 10 - $weighted_sum % 10 ) % 10;

    return $check_digit;
}

sub mul ( $a, $b ) {
    return $a * $b;
}

1;
