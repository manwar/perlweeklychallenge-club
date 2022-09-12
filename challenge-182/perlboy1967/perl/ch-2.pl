#!/bin/perl

=pod

The Weekly Challenge - 182
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-182/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Common Path
Submitted by: Julien Fiegehenn

Given a list of absolute Linux file paths, determine the deepest path to the directory that contains all of them.

=cut

use v5.16;
use warnings;

use List::Util qw(uniq);
use List::MoreUtils qw(each_arrayref);

my @l = qw(
  /a/b/c/1/x.pl
  /a/b/c/d/e/2/x.pl
  /a/b/c/d/3/x.pl
  /a/b/c/4/x.pl
  /a/b/c/d/5/x.pl
);


sub commonPath (@) {

  my @c;

  my $ea = each_arrayref map{ [ split '/' ] } @_;
  while (my @s = $ea->()) {
    if (scalar uniq(@s) == 1) {
      push(@c,shift @s);
    } else {
      last;
    }
  }

  return (scalar @c ? join('/',@c) : '/');
}


say commonPath(@l);
