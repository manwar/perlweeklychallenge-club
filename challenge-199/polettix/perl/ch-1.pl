#!/usr/bin/env perl
use v5.24;
say good_pairs(@ARGV ? @ARGV : (1, 2, 3, 1, 1, 3));
sub good_pairs { my $s = 0; my %c; $s += $c{$_}++ for @_; $s }
