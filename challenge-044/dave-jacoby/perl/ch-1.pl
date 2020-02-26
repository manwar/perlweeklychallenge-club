#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures };
no warnings qw{ experimental::signatures };

my $instructions =<<'END';

You are given a string “123456789”. Write a script that would 
insert ”+” or ”-” in between digits so that when you evaluate, 
the result should be 100.

END

# given that this is the only string and the only result,
# we are given leave to hard-code things that, with easier
# coding but harder thinking, would be more general. this
# is a custom-to-the-task solution.

# clearly, adding one + or - to a central position is not
# going to work so between any two numbers there will be
# inserted either a '+', a '-' or a '', and we eval each 
# time. I dislike eval but here we go.

# for a more general solution, I might make it recursive
# passing string, values, total, index and current state,
# and only evaluating when index is highter than the length
# of string. but I have a list of solutions, so not tonight.

my @vals = ('',' + ',' - ');
for my $i (@vals) {
	for my $j (@vals) {
		for my $k (@vals) {
			for my $l (@vals) {
				for my $m (@vals) {
					for my $n (@vals) {
						for my $o (@vals) {
							for my $p (@vals) {
								for my $q (@vals) {
									my $string = join '','1',$i,'2',$j,'3',$l,'4',$m,'5',$n,'6',$o,'7',$p,'8',$q,'9';
									my $resp = eval $string;
									next unless $resp == 100;
									say qq{$resp = $string};
								}
							}
						}
					}
				}
			}
		}
	}
}

__DATA__

The correct solutions

100 = 123 + 45 - 67 + 8 - 9
100 = 123 + 4 - 5 + 67 - 89
100 = 123 - 45 - 67 + 89
100 = 123 - 4 - 5 - 6 - 7 + 8 - 9
100 = 123 + 45 - 67 + 8 - 9
100 = 123 + 4 - 5 + 67 - 89
100 = 123 - 45 - 67 + 89
100 = 123 - 4 - 5 - 6 - 7 + 8 - 9
100 = 123 + 45 - 67 + 8 - 9
100 = 123 + 4 - 5 + 67 - 89
100 = 123 - 45 - 67 + 89
100 = 123 - 4 - 5 - 6 - 7 + 8 - 9
100 = 12 + 3 + 4 + 5 - 6 - 7 + 89
100 = 12 + 3 - 4 + 5 + 67 + 8 + 9
100 = 12 + 3 + 4 + 5 - 6 - 7 + 89
100 = 12 + 3 - 4 + 5 + 67 + 8 + 9
100 = 12 + 3 + 4 + 5 - 6 - 7 + 89
100 = 12 + 3 - 4 + 5 + 67 + 8 + 9
100 = 12 - 3 - 4 + 5 - 6 + 7 + 89
100 = 12 - 3 - 4 + 5 - 6 + 7 + 89
100 = 12 - 3 - 4 + 5 - 6 + 7 + 89
100 = 1 + 23 - 4 + 56 + 7 + 8 + 9
100 = 1 + 23 - 4 + 5 + 6 + 78 - 9
100 = 1 + 23 - 4 + 56 + 7 + 8 + 9
100 = 1 + 23 - 4 + 5 + 6 + 78 - 9
100 = 1 + 23 - 4 + 56 + 7 + 8 + 9
100 = 1 + 23 - 4 + 5 + 6 + 78 - 9
100 = 1 + 2 + 34 - 5 + 67 - 8 + 9
100 = 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9
100 = 1 + 2 + 34 - 5 + 67 - 8 + 9
100 = 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9
100 = 1 + 2 + 34 - 5 + 67 - 8 + 9
100 = 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9