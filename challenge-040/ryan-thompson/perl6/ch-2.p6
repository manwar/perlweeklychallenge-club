#!/usr/bin/env perl6

# ch-2.p6 - Sorting with slices
#
# Ryan Thompson <rjt@cpan.org>

my @list = <10 4 1 8 12 3>;
my @idx  = <0 2 5>;

# Note that Raku's sort, unlike Perl5's, will do
# a numeric sort if the list is numeric.

@list[@idx] = @list[@idx].sort;

@list.say;
