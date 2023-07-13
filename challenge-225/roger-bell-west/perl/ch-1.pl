#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(maxwords(['Perl and Raku belong to the same family.', 'I love Perl.', 'The Perl and Raku Conference.']), 8, 'example 1');
is(maxwords(['The Weekly Challenge.', 'Python is the most popular guest language.', 'Team PWC has over 300 members.']), 7, 'example 2');

use List::Util qw(max);

sub maxwords($a) {
  return 1 + max(map {s/\S+//g; length($_)} @{$a});
}
