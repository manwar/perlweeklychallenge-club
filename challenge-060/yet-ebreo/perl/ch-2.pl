#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics qw(variations);

my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;
if (@ARGV > 2) {
    $Y = pop @ARGV;
    $X = pop @ARGV;
    @L = @ARGV;
}

say @{$_} for grep { 
    (($X == length ($% = join "",@{$_})) && ($% < $Y)) 
} variations(\@L,$X);

=begin
perl .\ch-2.pl        
10
12
15
20

perl .\ch-2.pl 0 1 3 9 1 5
0
1
3

perl .\ch-2.pl 0 1 3 9 2 20
10
13
19

perl .\ch-2.pl 0 1 3 9 3 600
103
109
130
139
190
193
301
309
310
319
390
391
=cut