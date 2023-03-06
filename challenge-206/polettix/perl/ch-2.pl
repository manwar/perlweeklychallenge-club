#!/usr/bin/env perl
use List::Util qw< pairkeys sum >;
print array_pairings(@ARGV), "\n";
sub array_pairings { sum pairkeys sort { $a <=> $b } @_ }
