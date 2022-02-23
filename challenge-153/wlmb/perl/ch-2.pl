#!/usr/bin/env perl
# Perl weekly challenge 153
# Task 2: Factorions
#
# See https://wlmb.github.io/2022/02/21/PWC153/#task-2-factorions
use v5.12;
use warnings;
use Memoize;
use List::Util qw(sum0);
memoize qw(factorial);
die "Usage: ./ch-2.pl N1 N2...\nto test if Ni is factorion" unless @ARGV;
foreach(@ARGV){
    say("Expected a non-negative integer: $_"), next unless $_>=0;
    my @digits=split '';
    my @factorials=map {factorial($_)} @digits;
    my $sum=sum0(@factorials);
    my $factorion=$sum==$_;
    say "$_ is", $factorion?"":" not", " factorion as ",
        join("! + ", @digits), "! = ", join(" + ",@factorials),
	" = $sum ", $factorion?"== ":"!= ", $_;
}
sub factorial {
    my $n=shift;
    return 1 if $n<=0;
    return $n*factorial($n-1);
}
