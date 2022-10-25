#!/usr/bin/env perl
# Perl weekly challenge 188
# Task 1:  Divisible Pairs
#
# See https://wlmb.github.io/2022/10/25/PWC188/#task-1-divisible-pairs
use v5.36;
use Algorithm::Combinatorics qw(combinations);
die <<EOF unless @ARGV>=3;
Usage: $0 D N1 N2 [N3...]\nto count distinct ordered pairs of integers Ni
that add to a multiple of D
EOF
my $divisor=shift;
my @list=sort @ARGV;
my $iter=combinations(\@list, 2);
my $count=0;
while(my $z=$iter->next){
    my ($x, $y)=@$z;
    ++$count if ($x+$y)%$divisor==0;
}
say "The number of pairs from the list ",
    join(", ", @ARGV), " divisible by $divisor is $count";
