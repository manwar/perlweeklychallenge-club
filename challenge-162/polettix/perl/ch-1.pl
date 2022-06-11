#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< pairmap sum >;

my $input = shift // '978-0-306-40615-7';
say "ISBN-13 check digit for '$input' is @{[isbn_13($input)]}.";

sub isbn_13 ($input) {
   sum(
      pairmap { -$a - 3* $b }
      ($input =~ m{(\d)}gmxs)[0 .. 11]
   ) % 10;
}
