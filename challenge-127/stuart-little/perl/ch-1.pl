#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated set entries, with a '-' separating the two sets>

use List::AllUtils qw(before after);
use Set::Scalar;

my $s1=Set::Scalar->new(before {$_ eq "-"} @ARGV);
my $s2=Set::Scalar->new(after {$_ eq "-"} @ARGV);

say int($s1->is_disjoint($s2));
