#!/usr/bin/env perl
# Perl weekly challenge 222
# Task 2:  Last Member
#
# See https://wlmb.github.io/2023/06/19/PWC222/#task-2-last-member
use v5.36;
use List::Util qw(first all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find last member from list N1 N2...
    after iteratively eliminating equal pairs
    and replacing unequal pairs by their differences,
    starting from the highest values.
    FIN
# If non-positive are allowed, the result 0 becomes ambiguous.
# Not necessary to check for integers, though.
die "Expected positive numbers" unless all {$_>0} @ARGV;
my @list = sort {$b <=> $a} @ARGV;
while(@list>1){
    my ($x, $y)=splice @list, 0, 2; # Remove largest two elements.
    next unless $x-=$y;             # Were they equal?
    my $i=(first {$list[$_]<=$x} 0..@list - 1) // @list + 1; # No. Fin where to insert difference
    splice @list, $i, 0, $x;
}
say "@ARGV->", $list[0]//0; # Print single remaining element or 0 if none.
