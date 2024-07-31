#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(countcommon(['Perl', 'is', 'my', 'friend'], ['Perl', 'and', 'Raku', 'are', 'friend']), 2, 'example 1');
is(countcommon(['Perl', 'and', 'Python', 'are', 'very', 'similar'], ['Python', 'is', 'top', 'in', 'guest', 'languages']), 1, 'example 2');
is(countcommon(['Perl', 'is', 'imperative', 'Lisp', 'is', 'functional'], ['Crystal', 'is', 'similar', 'to', 'Ruby']), 0, 'example 3');

sub countcommon($a, $b) {
  my %ac;
  map {$ac{$_}++} @{$a};
  my %bc;
  map {$bc{$_}++} @{$b};
  return scalar grep {$ac{$_} == 1 && exists $bc{$_} && $bc{$_} == 1} keys %ac;
}
