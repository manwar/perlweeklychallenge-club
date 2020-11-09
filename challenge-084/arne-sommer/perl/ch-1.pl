#! /usr/bin/env perl

use feature 'say';

my $N = $ARGV[0] // die "Please specify an integer";

die "Integer only" unless $N =~ /^\-?\d+$/;

my $sign = $N < 0
  ? "-"
  : "";
  
my $new = $sign . reverse(abs($N));

($new >= -2147483648 && $new <= 2147483647)
  ? say $new
  : say "0";
