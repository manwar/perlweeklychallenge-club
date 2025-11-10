#!/usr/bin/env perl
# Perl weekly challenge 346
# Task 2:  Magic Expression
#
# See https://wlmb.github.io/2025/11/02/PWC346/#task-2-magic-expression
use v5.36;
use feature qw(try);
use Algorithm::Combinatorics qw(tuples_with_repetition);
use Scalar::Util qw(looks_like_number);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S0 T0 S1 T1...
    to intercalate arithmetic operators among the digits of string Sn
    to produce target Tn
    FIN
for my($string, $target)(@ARGV){
    try {
	die "Empty string" unless $string ne "";
        die "Only digits accepted in string: $string" unless $string=~/^\d*$/;
        die "Target doesn't looks like number: $target" unless looks_like_number($target);
        my @digits=split "", $string;
        my $iterator=tuples_with_repetition(["",qw(+ - * /)], @digits-1);
        my @results=();
        while(my $intercalate=$iterator->next){
            my $expression=join "",
                map({($digits[$_], $intercalate->[$_])} 0..@digits-2),
                $digits[-1];
            next if $expression=~/(^|\D)0\d/; # forbid leading zeros
            my $value = eval $expression;
            next unless defined $value; # ignore illegal expressions
            push @results, $expression if $value==$target;
        }
        say "$string,  $target -> @results";
    }
    catch($e){warn $e;}
}
