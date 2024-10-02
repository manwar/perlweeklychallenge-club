#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(uniqint);

my @unique_ints = uniqint sort { $b <=> $a } @ARGV;
say $unique_ints[2] // $unique_ints[0];

__END__
