#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @wiggled = wiggle_sort_sloppy(@ARGV ? @ARGV : (1, 5, 1, 1, 6, 4));
{local $" = ','; say "(@wiggled)"}

sub wiggle_sort_sloppy (@list) {
   @list = sort { $a <=> $b } @list;
   my @upper = splice @list, int((@list + 1) / 2);
   map { $_, (@upper ? shift(@upper) : ()) } @list;
}
