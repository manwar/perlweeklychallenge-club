#!/usr/bin/env perl
# Perl weekly challenge 160
# Task 1: Four is magic
#
# See https://wlmb.github.io/2022/04/11/PWC160/#task-1-four-is-magic
use v5.12;
use warnings;
die <<'END' unless @ARGV >= 2;
Usage: ./ch-1a.pl "S1 [S2... ]" N1 [N2...]\n
    to find all trajectories between strings S1 S2...
    starting from position N1, N2...
    The mapping function uses the length of a string as an index
    to the next string
END
my @strings=split " ", shift;
foreach my $index(@ARGV){
    my @seen;
    while(1){
	say("$strings[$index] is magic"), last if (my $next=next_index($index))==$index;
	say("$strings[$index] is magic loop"), last if $seen[$index];
	say("$index->nothing"), last unless defined $next;
	$seen[$index]++;
	print "$strings[$index] is $strings[$next], ";
	$index=$next;
    }
}
sub next_index {
    my $current=shift;
    my $next=length $strings[$current]; # Could use other mappings
    return undef unless defined $strings[$next];
    return $next;
}
