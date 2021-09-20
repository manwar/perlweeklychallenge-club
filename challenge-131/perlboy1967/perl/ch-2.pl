#!/usr/bin/perl

# Perl Weekly Challenge - 131
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-131/#TASK2
#
# Task 2 - Find Pairs
#
# Author: Niels 'PerlBoy' van Dijke

# ******* NOTE ******
# I think the task outputs are incorrect. However, "sub findPairs" does what is
# asked for. "sub findMatchingPairs" is probably what was wanted
# *******************

use v5.16;
use strict;
use warnings;
use strict;
use warnings;

use Data::Printer;

use List::MoreUtils qw(pairwise);

use Test::More;
use Test::Deep;

my @tests = (
  [
    q{""[]()},
    q{"I like (parens) and the Apple ][+" they said.},
    [q{"(["},q{")]"}],
    [q{"(},q{")}]
  ],
  [
    q{**//<>},
    q{/* This is a comment (in some languages) */ <could be a tag>},
    [q{/**/<},q{/**/>}],
    [q{/*<},q{/*>}]
  ],
  [
    q{+-()||},
    q{|0.5000000001| is +/- the ratio of 1/2 (give or take)},
    [q{||+(},q{||-)}],
    [q{|+(},q{|-)}],
  ]
);

foreach my $t (@tests) {
  cmp_deeply(findPairs($t->[0],$t->[1]),$t->[2]);
  cmp_deeply(findMatchingPairs($t->[0],$t->[1]),$t->[3]);
}
done_testing;


sub findPairs {
  my ($d,$s) = @_;

  my (@d,@cs);

  while ($d =~ s#(?<m0>.)(?<m1>.)##) {
    $cs[$_] .= quotemeta $+{"m$_"} foreach (0,1);
  }

  foreach my $i (0,1) {
    my $t = $s;
    $d[$i] .= $1 while ($t =~ s#([$cs[$i]])##);
  }

  return \@d; 
}


sub findMatchingPairs {
  my ($d,$s) = @_;

  my (@d,%c,%d);

  $c{$1} .= $2 while ($d =~ s#(.)(.)##);
  map { $d{$_} = quotemeta $c{$_} } keys %c;

  my $cs = join('', map { quotemeta } keys %d);

  while ($s =~ s#([$cs])(.*)##) {
    my ($c,$t) = ($1,$2);

    if ($t =~ s#([$d{$c}])##) {
      $d[1] .= $1;
      $d[0] .= $c;
      $s = $t;
    } else {
      warn "Delimiter '$c{$c}' not found to match '$c'";
    }
  }

  return \@d;
}
