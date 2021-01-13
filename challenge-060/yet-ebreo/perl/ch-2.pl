#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics qw(variations_with_repetition);

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
} variations_with_repetition(\@L,$X);

=begin
perl .\ch-2.pl
10
11
12
15
20

perl .\ch-2.pl 0 1 3 9 1 5
0
1
3

perl .\ch-2.pl 0 1 3 9 2 20 
10
11
13
19

perl .\ch-2.pl 0 1 3 9 3 600
100
101
103
109
110
111
113
119
130
131
133
139
190
191
193
199
300
301
303
309
310
311
313
319
330
331
333
339
390
391
393
399
=cut