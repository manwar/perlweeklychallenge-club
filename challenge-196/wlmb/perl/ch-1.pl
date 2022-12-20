#!/usr/bin/env perl
# Perl weekly challenge 196
# Task 1:  Pattern 132
#
# See https://wlmb.github.io/2022/12/19/PWC196/#task-1-pattern-132
use v5.36;
use Algorithm::Combinatorics qw(combinations);
say(<<"FIN"), exit unless @ARGV && @ARGV>=3;
Usage: $0 N1 N2 N3 [N4...]
to find the first 132 pattern in the sequence N1 N2...
FIN
my $c=combinations(\@ARGV, 3);
while(my $n=$c->next){
    say(join " ", @ARGV, "->", @$n), exit if $n->[0]<$n->[2]<$n->[1];
}
say join " ", @ARGV, "->";
