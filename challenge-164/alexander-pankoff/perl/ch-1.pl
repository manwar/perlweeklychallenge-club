#!/usr/bin/env perl

=pod
Task 1: Prime Palindrome
Submitted by: Mohammad S Anwar

Write a script to find all prime numbers less than 1000, which are also
palindromes in base 10. Palindromic numbers are numbers whose digits are the
same in reverse. For example, 313 is a palindromic prime, but 337 is not, even
though 733 (337 reversed) is also prime.
=cut

package challenge164::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();

use lib File::Spec->catdir( $FindBin::RealBin,
    qw'.. .. .. challenge-001 alexander-pankoff perl lib' );

use My::Prime::Util qw(is_prime);
use My::String::Util qw(is_palindromic);

run() unless caller();

sub run() {
    say join( "\n", grep { is_palindromic($_) && is_prime($_) } 0 .. 1000 );
}
