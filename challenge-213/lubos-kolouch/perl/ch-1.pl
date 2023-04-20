#!/usr/bin/perl
use strict;
use warnings;

sub fun_sort {
    my @list = @_;
    my @even = sort { $a <=> $b } grep { $_ % 2 == 0 } @list;
    my @odd = sort { $a <=> $b } grep { $_ % 2 == 1 } @list;
    return (@even, @odd);
}

my @input = (1, 2, 3, 4, 5, 6);
my @output = fun_sort(@input);
print "Input: \@list = (", join(",", @input), ")\n";
print "Output: (", join(",", @output), ")\n";

