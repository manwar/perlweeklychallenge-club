#!/bin/perl

=pod

The Weekly Challenge - 171 - Task 2
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-171/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: First-class Function
Submitted by: Mohammad S Anwar

Create sub compose($f, $g) which takes in two parameters $f and $g as subroutine
refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x))

=cut

use v5.16;
use warnings;

use List::Util qw(sum);
use List::MoreUtils qw(apply);

sub compose ($$);

my $f = \&sum;
my $g = sub { apply { $_ *= 2 } @_ };
my @list1 = (1,2,3);
my @list2 = (2,3,4);

say compose($f,$g)->(@list1);
say $f->($g->(@list1));

$g = sub { apply { $_ *= 3 } @_ };
say $f->($g->(@list2));
say compose($f,$g)->(@list2);

sub compose ($$) {
  my $f = shift; die unless ref($f) eq 'CODE';
  my $g = shift; die unless ref($g) eq 'CODE';
  sub { $f->($g->(@_)) };
}
