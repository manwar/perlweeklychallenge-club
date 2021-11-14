#!/usr/bin/env perl
# Perl weekly challenge 133
# Task 2: Smith numbers
#
# See https://wlmb.github.io/2021/10/06/PWC133/#task-2-smith-numbers
use v5.12;
use warnings;
use POSIX qw(floor);
use Math::Prime::Util qw(is_prime factor);
use List::Util qw(sum0);
use integer;

my ($desired, $base)=map {floor $_} (@ARGV);
$desired//=10;
$base//=10;
die "Usage: './ch-2.pl desired base' with desired>=0 and base >=2"
     unless $base>=2 and $desired>0;
my @smith=();
my $N=4; # First non-prime
while(@smith<$desired){
    push @smith, $N if is_smith($N, $base);
    ++$N;
}
say join " ", "First $desired Smith numbers in base $base:", @smith;

sub is_smith {
    my ($N, $base)=@_;
    return 0 if is_prime($N);
    my $sum_digits=sum0 digits($N, $base);
    my $sum_factors=sum0 map {digits($_, $base)} factor($N);
    return $sum_digits==$sum_factors;
}

sub digits {
    my ($N,$base)=@_;
    my @digits;
    while($N){
	push @digits, $N%$base;
	$N/=$base;
    }
    @digits;
}
