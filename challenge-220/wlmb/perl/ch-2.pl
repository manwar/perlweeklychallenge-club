#!/usr/bin/env perl
# Perl weekly challenge 220
# Task 2:  Squareful
#
# See https://wlmb.github.io/2023/06/05/PWC220/#task-2-squareful
use v5.36;
use POSIX qw(floor);
use List::Util qw(all);
use Algorithm::Combinatorics qw(permutations);
die <<~"FIN" unless @ARGV>=2;
     Usage: $0 N1 N2 [N3...]
     to print all squarefull permutations of N1 N2...
     FIN
say "@ARGV ->";
my %seen;
for(permutations[@ARGV]){
    my @permutation=@$_;
    next if $seen{"@permutation"};
    $seen{"@permutation"}++;
    say "    @permutation"
	if all {my $x=sqrt($_); $x==floor $x}
        map {$permutation[$_]+$permutation[$_+1]}
        0..@permutation-2;
}
