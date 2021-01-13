#! /usr/bin/env perl

use Algorithm::Combinatorics qw(combinations);
use feature 'say';

my $m = shift(@ARGV) || die 'Please specify $m and $n';
my $n = shift(@ARGV) || die 'Please specify $n';

die "XX" unless int($m) == $m;
die "XX" unless int($n) == $n;

die "XX" unless $m > 0;
die "XX" unless $n > 0;

my @numbers = 1 .. $m;

my @answer;

my $iter = combinations(\@numbers, $n);
while (my $c = $iter->next)
{
  push(@answer, "[" . join(",", @{$c}) . "]");
}

say "[ ", join(", ", @answer), " ]";
