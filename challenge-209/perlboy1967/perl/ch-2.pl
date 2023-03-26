#!/bin/perl

=pod

The Weekly Challenge - 209
- https://theweeklychallenge.org/blog/perl-weekly-challenge-209

Author: Niels 'PerlBoy' van Dijke

Task 2: Merge Account
Submitted by: Mohammad S Anwar

You are given an array of accounts i.e. name with list of email addresses.

Write a script to merge the accounts where possible. The accounts can only
be merged if they have at least one email address in common.

=cut

use v5.16;

use common::sense;

use List::MoreUtils qw(uniq duplicates);

use Test::More;
use Test::Deep qw(cmp_deeply);

sub mergeAccount {

  # Change all e-mail addresses to lowercase
  @_ = map {[shift @$_,map {lc} @$_]} @_;

  my @a = shift;

  while (my $r = shift) {
    my ($b,@e) = @$r;
    my $u = 1;
    for my $i (0 .. scalar @a - 1) {
      my ($c,@c) = @{$a[$i]};
      if (duplicates(@c,@e)) {
        push(@{$a[$i]},@e); $u = 0; last;
      }
    }
    push(@a,[$b,@e]) if $u; 
  }

  return map {[shift @$_,uniq sort @$_]}
               sort { $$a[0] cmp $$b[0] } @a;
}

cmp_deeply(
  [mergeAccount(@{[
    [qw(A A1@a.com a2@a.com)],
    [qw(B B1@b.com)],
    [qw(A a3@a.com a1@a.com)],
  ]})],
  [
    [qw(A a1@a.com a2@a.com a3@a.com)],
    [qw(B b1@b.com)],
  ]
);
cmp_deeply(
  [mergeAccount(@{[
    [qw(A a1@a.com a2@a.com)],
    [qw(B b1@b.com)],
    [qw(A a3@a.com)],
    [qw(B b2@b.com b1@b.com)],
  ]})],
  [
    [qw(A a1@a.com a2@a.com)],
    [qw(A a3@a.com)],
    [qw(B b1@b.com b2@b.com)],
  ]
);

done_testing;
