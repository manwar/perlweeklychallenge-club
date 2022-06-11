#!/usr/bin/env perl
# Perl weekly challenge 154
# Task 2: Padovan Prime
#
# See https://wlmb.github.io/2022/02/28/PWC154/#task-2-padovan-prime
use v5.12;
use warnings;
use Memoize;
use bigint;
use Math::Prime::Util qw(is_prime);

memoize("padovan");
die "Usage: ./ch-2.pl N\nto get the first N Padovan primes" unless @ARGV;
my %seen;
my $i=0;
my $N=shift;
say "The first $N distinct Padovan primes are:";
for(1..$N){
    my $padovan=padovan($i++);
    redo if $seen{$padovan} || !is_prime($padovan); # Keep searching
    say("$padovan");
    $seen{$padovan}++; # save to avoid repetitions
}
sub padovan {
    my $n=shift;
    return 1 if $n<=2;
    padovan($n-2)+padovan($n-3);
}
