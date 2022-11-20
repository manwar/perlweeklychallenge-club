#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 1:  Twice Largest
#
# See https://wlmb.github.io/2022/11/14/PWC191/#task-1-twice-largest
use v5.36;
use List::Util qw(all);
use Scalar::Util qw(looks_like_number);
die <<"EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to test if the largest among Ni is at least as large as twice
any of the others.
EOF
die "Only numbers allowed" unless all {looks_like_number($_)} @ARGV;
my @x=sort{$b <=> $a} @ARGV;
say "@ARGV -> ", $x[0] >= 2*$x[1]?1:-1
