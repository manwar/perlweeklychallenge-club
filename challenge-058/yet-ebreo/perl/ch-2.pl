#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my %hash;

my @heights = qw(2 6 4 5 1 3); 
my @taller  = qw(1 0 2 0 1 2); 
@heights = eval "qw($ARGV[0])" if $ARGV[0];
@taller  = eval "qw($ARGV[1])" if $ARGV[1];

@hash{@heights} = @taller;
my @sorted = sort {$b-$a} keys %hash;

for my $i (0..$#sorted) {
    splice @sorted, $hash{$sorted[$i]}, 0, splice @sorted, $i, 1;
}

say "@sorted";

=begin
perl .\ch-2.pl
5 1 2 6 3 4

perl .\ch-2.pl "1 2 3 4 5 6" "2 1 1 1 1 0" 
6 2 1 3 4 5
=cut
