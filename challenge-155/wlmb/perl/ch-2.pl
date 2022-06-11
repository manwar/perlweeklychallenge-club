#!/usr/bin/env perl
# Perl weekly challenge 155
# Task 2: Pisano period
#
# See https://wlmb.github.io/2022/03/07/PWC155/#task-2-pisano-period
use v5.12;
use warnings;
use Memoize;
memoize("fib");
say("Usage: ./ch-2.pl n1 [n2 [n3...]]\n",
      "to obtain the Pisano period of the Fibonacci sequence modulo n_i")
      unless @ARGV;
for my $N(@ARGV){
    my $n=0;
    my @seen;
    while(1){
        my $s=$seen[fib($n, $N)][fib($n+1, $N)];
        say("Input: $N Output: ", $n-$s), last
            if defined $s;
	$seen[fib($n, $N)][fib($n+1, $N)]=$n;
	++$n;
    }
}

sub fib{
    my ($n, $N)=@_;
    return 0 if $n<=0;
    return 1%$N if $n==1;
    return (fib($n-2, $N)+fib($n-1, $N))%$N;
};
