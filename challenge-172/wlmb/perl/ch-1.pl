#!/usr/bin/env perl
# Perl weekly challenge 172
# Task 1: Prime partition
#
# See https://wlmb.github.io/2022/07/04/PWC172/#task-1-prime-partition
use v5.36;
use Math::Prime::Util qw(primes);
say("Usage: ./ch-1.pl M N\nto find the N-term prime partitions of M\n"), exit
    unless @ARGV==2;
my ($m,$n)=@ARGV;
my @primes=@{primes($m)};
my @result= partitions($m,$n,\@primes);
say "$m=", join "+", @$_ foreach @result;
sub partitions($m, $n, $set){
    # return all partitions of $m into $n elements of the ordered $set
    return $m==0?([]):() if $n==0; # () means failure, ([]) means we are done
    my @set=grep {$_<=$m} @$set; # remove high unneeded elements
    my @results=();
    while(@set){
        my $element=pop @set; # try highest elements first
        my @r=partitions($m-$element, $n-1, \@set);
        push @results, map {push @$_, $element; $_} @r if @r;
    }
    return @results;
}
