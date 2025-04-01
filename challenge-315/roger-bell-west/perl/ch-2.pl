#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(findthird('Perl is a my favourite language but Python is my favourite too.', 'my', 'favourite'), ['language', 'too'], 'example 1');
is_deeply(findthird('Barbie is a beautiful doll also also a beautiful princess.', 'a', 'beautiful'), ['doll', 'princess'], 'example 2');
is_deeply(findthird('we will we will rock you rock you.', 'we', 'will'), ['we', 'rock'], 'example 3');

use List::MoreUtils qw(slideatatime);

sub findthird($s, $a, $b) {
  my @ss;
  my $sa = "";
  foreach my $c (split '', $s) {
    if ( $c =~ /[][:alpha:]]/) {
      $sa .= $c;
    } else {
      if (length($sa) > 0) {
        push @ss, $sa;
        $sa = "";
      }
    }
  }
  if (length($sa) > 0) {
    push @ss, $sa;
  }
  my @out;
  my $dd = slideatatime(1, 3, @ss);
  while (my @p = $dd->()) {
    if (scalar @p == 3) {
      if ($p[0] eq $a && $p[1] eq $b) {
        push @out, $p[2];
      }
    }
  }
  \@out;
}
