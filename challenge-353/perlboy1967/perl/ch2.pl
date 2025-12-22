#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-353#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Validate Coupon
Submitted by: Mohammad Sajid Anwar

You are given three arrays, @codes, @names and @status.

Write a script to validate codes in the given array.

A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
- status[i] is true.

Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(each_array);

sub validateCoupon ($arCodes,$arNames,$arStatus) {
  my @results;

  state $validNames = {map {($_,1)} qw(electronics grocery pharmacy  restaurant)};

  my $ea = each_array(@$arCodes,@$arNames,@$arStatus);
  while (my ($code,$name,$status) = $ea->()) {
    push(@results,
         boolean(
           $status == true and
           exists $validNames->{$name} and
           $code =~ /^[a-zA-Z0-9_]+$/
         ));
  }

  return @results;
}

is([validateCoupon(
     [qw(A123 B_456 C789 D@1 E123)],
     [qw(electronics restaurant electronics pharmacy grocery)],
     [true,false,true,true,true])],
   [true,false,true,false,true],'Example 1');
is([validateCoupon(
     [qw(Y2025)],
     [qw(coding)],
     [true])],
   [false],'Own Example');

done_testing;
