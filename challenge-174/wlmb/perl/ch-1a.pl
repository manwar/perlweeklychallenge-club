#!/usr/bin/env perl
# Perl weekly challenge 174
# Task 1: Disarium numbers. Not so brute force
#
# See https://wlmb.github.io/2022/07/18/PWC174/#task-1-disarium-numbers
use v5.36;
use List::Util qw(sum min);
use Memoize;
memoize "power";
die "Usage: $0 N\nto obtain the first N Disarium numbers\n" unless @ARGV;
my $want=shift;
die "There are not that many Disarium numbers\n" if $want > 20;
die "We are not that patient today\n" if $want==20;
my $count=1;
say $count++, ": $_" for(0..min 9, $want);
for my $N(2..20){ # for each possible length
    search($N, $N, "", 0, 0);
}
sub search ($N, $M, $rightmost, $p_old, $d_old){
    --$M;
    my $minmin=power(10,$M-1);
    for my $right(0..9){ # for each possible rightmost digit
        last if $count > $want;
        my $p_new=power($right, $M+1)+$p_old;
        my $d_new=$right*power(10, $N-$M-1)+$d_old;
        my $min=($p_new-$d_new+1)/power(10, $N-$M);
        my $max=($p_new-$d_new+(power(9,$M+1)-9)/8)/power(10, $N-$M);
        $min=$minmin if $min<$minmin;
        next if $max<=$min;
        my $newright="$right$rightmost";
	if($max-$min < 10){
	    for($min..$max){
                my $candidate="$_$newright";
                say $count++, ": $candidate" if disarium($candidate);
            }
        } else {
            search($N, $M, $newright, $p_new, $d_new);
        }
    }
}
sub power($x, $y){ $x**$y }
sub disarium($candidate){
    my @digits=split "", $candidate;
    my $powersum=sum map {$digits[$_-1]**$_} (1..@digits);
    return $powersum==$candidate;
}
