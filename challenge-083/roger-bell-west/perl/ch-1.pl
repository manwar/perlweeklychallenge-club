#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is (wl('The Weekly Challenge'),6,'example 1');
is (wl('The purpose of our lives is to be happy'),23,'example 2');

sub wl {
  my $s=shift;
  $s =~ s/^\S+\s+(.*?)\s+\S+$/$1/;
  $s =~ s/\s+//g;
  return length($s);
}
