#!/bin/perl

=pod

The Weekly Challenge - 185
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-185/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 1: Zip List
Submitted by: Mohammad S Anwar

You are given two list @a and @b of same size.

Create a subroutine sub zip(@a, @b) that merge the two list as shown in the example below.
:
Example

Input:  @a = qw/1 2 3/; @b = qw/a b c/;
Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
        zip(@b, @a) should return qw/a 1 b 2 c 3/;

=cut

# Comment: In stead of creating an own 'zip' subroutine one is 
# maybe better off by using:
#
# use List::MoreUtils qw(zip)
# 
# As this one is written in C (XS). And maybe performs better in
# large list usage.
#
# However, the challenge was: Create a subroutine. And so I did.
# The two list 'pure Perl' version seems to beet List::MoreUtils :-)
# But with the note: the lists are assumed equal length (no checks)

use v5.16;
use warnings;

use Benchmark qw(:all);

use List::MoreUtils qw(zip);

sub Zip (\@\@) { 
  my $i = 0;
  map { $_, $_[1][$i++] } @{$_[0]};
}

my @a = qw/1 2 3/; 
my @b = qw/a b c/;

say join(',', zip(@a,@b));
say join(',', Zip(@a,@b));
say join(',', zip(@b,@a));
say join(',', Zip(@b,@a));


cmpthese(1_000_000, {
  'List::MoreUtils' => sub { zip(@a,@b); zip(@b,@a) },
  'PerlBoy'         => sub { Zip(@a,@b); Zip(@b,@a) },
});
