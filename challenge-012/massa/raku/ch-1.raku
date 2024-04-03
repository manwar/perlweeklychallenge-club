#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Euclid Number

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

The numbers formed by adding one to the products of the smallest primes are
called the Euclid Numbers (see wiki). Write a script that finds the smallest
Euclid Number that is not prime. This challenge was proposed by Laurent
Rosenfeld..

=head3 Result

    Output: 30031

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION() {
  ^∞ ==> grep &is-prime ==> produce &[*] ==> map {$_+1} ==> first {!.is-prime}
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ output => 30031 },
    ;

    SOLUTION().&is: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


