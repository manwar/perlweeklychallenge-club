#!/usr/bin/env perl
# Perl weekly challenge 147
# Task 1: Truncatable prime
#
# See https://wlmb.github.io/2022/01/10/PWC147/#task-1-truncatable-prime
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
use POSIX qw(); # don't import to avoid name collisions with PDL
use Text::Wrap qw(wrap $columns $break);

die "Usage: ./ch-1.pl size_of_sieve number_of_truncatable_primes [base]\n"
    unless @ARGV>=2;
my ($size, $wanted, $base)=@ARGV;
$base//=10; # decimal numbers by default
$size=$base**POSIX::ceil(log($size)/log($base)); # Force power of base;
my $sieve=ones($size); #
$sieve(0:1).=0; # 0 and 1 are not primes
# find primes with Eratosthenes sieve
$sieve($_**2:-1:$_).=0 foreach(2..sqrt($size-1));
# Remove non-truncatable primes
for(my $n=$base; $n<$size; $n*=$base){
    # Reshape sieve as rectangle. The first row all log_base(n) digits
    $sieve->reshape($n,$size/$n);
    # Remove from the remaining rows those numbers which don't
    # correspond to a truncatable prime in the first row
    $sieve &= $sieve(:,0);
    # From every tenth row remove numbers that would begin in 0 if truncated
    $sieve(:,10:-1:10).=0 if $sieve->dim(1)>10;
}
$sieve->reshape($size); # return to a 1D sieve
# The desired primes correspond to the surviving ones in the sieve
my $truncatable_primes=$sieve->xvals->where($sieve);
my $found=$truncatable_primes->nelem; # truncatable primes actually found
say("Didn't find enough ($wanted) primes, please increase size of sieve"),
    $wanted=$found
    unless $found >= $wanted;
$columns=62; $break=qr/\s/;
say wrap("", "    ", "The first $wanted truncatable primes are: ",
    join ", ", $truncatable_primes(0:$wanted-1)->list);
