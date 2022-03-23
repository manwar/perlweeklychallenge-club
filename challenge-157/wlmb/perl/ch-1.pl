#!/usr/bin/env perl
# Perl weekly challenge 157
# Task 1: Pythagorean means
#
# See https://wlmb.github.io/2022/03/21/PWC157/#task-1-pythagorean-means
use v5.12;
use warnings;
use List::Util qw(sum0 product any);
die "Usage: ./ch-1.pl N1 N2 N3 ... to get the means of the numbers Ni..." unless @ARGV;
say "In: ", join ", ", @ARGV;
my $AM= sprintf "%.2f", sum0(@ARGV)/@ARGV;            # arithmetic mean
my $product=product(@ARGV);
my $GM=($product<0 && @ARGV%2==0)? "Undefined":sprintf "%.2f", $product**(1/@ARGV);
my $HM=(any{$_==0} (@ARGV))?"Undefined":sprintf "%.2f", @ARGV/sum0(map {1/$_} (@ARGV));
say sprintf "AM=$AM GM=$GM HM=$HM";
