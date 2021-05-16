#!/usr/bin/perl

# Perl Weekly Challenge - 112
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/#TASK1
#
# Task 1 - Canonical Path
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub canonicalPath($);

my %test = (
  '/a/'          => '/a',
  '/a/.'         => '/a',
  '/a/b//c/'     => '/a/b/c',
  '/a/b/./c/'    => '/a/b/c',
  '/a/./b'       => '/a/b',
  '/a/b/../c/'   => '/a/c',
  '/a/b/c/../..' => '/a',
  '/a/..'        => '/',
);

foreach my $path (sort keys %test) {
  is(canonicalPath($path), $test{$path});
}

done_testing;

sub canonicalPath($) {
  my ($p) = @_;

  do {
    $p =~ s#(//|/\./|/\.\Z)#/#g;
  } while ($p =~ s#[^/]+/\.\.##);
  return $p =~ s#(?!\A)/$##r;
}
