#!/usr/bin/env perl
# Perl weekly challenge 163
# Task 2: Summations
#
# See https://wlmb.github.io/2022/05/02/PWC163/#task-2-summations
use v5.12;
use warnings;
use Memoize;
memoize 'f';
die 'Usage: ./ch-2.pl "N0 [N1..]" "M0 [M1..]"...',
    'to obtain the strange summation of N0 N1..., of M0 M1..., etc.'
    unless @ARGV;
for(@ARGV){
    my @in=reverse split /\s+/;
    my $N=@in-1;
    my $sum=0;
    $sum+=f($N, $_)*$in[$_] for(0..$N);
    say "Input: $_ Output: $sum";
}
sub f{
    my ($n,$m)=@_;
    return 1 if $m==0;
    return 0 if $n==$m;
    f($n-1, $m)+f($n,$m-1);
}
