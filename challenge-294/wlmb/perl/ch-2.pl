#!/usr/bin/env perl
# Perl weekly challenge 294
# Task 2:  Next Permutation
#
# See https://wlmb.github.io/2024/11/04/PWC294/#task-2-next-permutation
use v5.36;
use List::AllUtils qw(first_index);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the next permutation of the numbers N1 N2...
    in lexicographic order.
    FIN
sub pattern($permutation, $original){
    my @permutation=@$permutation;
    my @original=@$original;
    my @result;
    for my $n(@permutation){
        my $first=first_index {$n == $_} @original;
	splice @original, $first, 1;
	push @result, $first;
    }
    return [@result];
}
sub next_pattern($permutation){
    my @permutation=@$permutation;
    my @next=reverse @permutation;
    for(0..@next-1){
	$next[$_]++;
	last unless $next[$_]>$_;
	$next[$_]=0;
    }
    return [reverse @next];
}
sub pattern_to_permutation($pattern, $original){
    my @pattern=@$pattern;
    my @original=@$original;
    my @result;
    for(@pattern){
	push @result, splice @original, $_, 1;
    }
    return [@result];
}

my @permutation=@ARGV;
my @sorted=sort {$a <=> $b} @permutation;
my $pattern=pattern([@permutation],[@sorted]);
my $next_pattern=next_pattern($pattern);
my $next_permutation=pattern_to_permutation($next_pattern, [@sorted]);
say "@permutation -> @$next_permutation";
