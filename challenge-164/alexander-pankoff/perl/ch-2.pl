#!/usr/bin/env perl

=pod
Write a script to find the first 8 Happy Numbers in base 10. For more
information, please check out Wikipedia.

Starting with any positive integer, replace the number by the sum of the squares
of its digits, and repeat the process until the number equals 1 (where it will
stay), or it loops endlessly in a cycle which does not include 1.

Those numbers for which this process end in 1 are happy numbers, while those
numbers that do not end in 1 are unhappy numbers.

Example

19 is Happy Number in base 10, as shown:

19 => 1^2 + 9^2
   => 1   + 81
   => 82 => 8^2 + 2^2
         => 64  + 4
         => 68 => 6^2 + 8^2
               => 36  + 64
               => 100 => 1^2 + 0^2 + 0^2
                      => 1 + 0 + 0
                      => 1
=cut

package challenge164::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();

use List::Util qw(all sum0);

use lib File::Spec->catdir( $FindBin::RealBin,
    qw'.. .. .. challenge-001 alexander-pankoff perl lib' );

run() unless caller();

sub run() {
    say join( "\n", happy_numbers(8) );

}

sub happy_numbers($n) {
    my @happy_numbers = ();
    for ( my $i = 0 ; @happy_numbers < $n ; $i++ ) {
        push @happy_numbers, $i if is_happy_number($i);
    }

    return @happy_numbers;
}

sub is_happy_number($n) {
    my %seen;

    while ( $n != 1 ) {
        return 0 if $seen{$n};
        $seen{$n} = 1;
        $n = sum0( map { $_**2 } split( m//, $n ) );
    }

    return 1;
}

