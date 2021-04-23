#!/usr/bin/env perl
# Perl weekly challenge 108
# Task 2: Bell numbers
# Triangle solution without enumeration.
#
# See https://wlmb.github.io/2021/04/12/PWC108/#task-2-bell-numbers
use strict;
use warnings;
use strict;
use v5.12;

my $last=shift @ARGV;
die "Usage: ./ch-2.pl last\n to generate Bell numbers up to last>=0"
    unless defined $last and $last >=0;
my @triangle=([1], [1]);
for my $row(1..$last-1){
    for my $col(1..$row){
	$triangle[$row][$col]=$triangle[$row-1][$col-1]+$triangle[$row][$col-1];
    }
    $triangle[$row+1][0]=$triangle[$row][$row];
}
my @bell=map {$triangle[$_][0]} (0..$last);
say "Bell($_)=$bell[$_]" for 0..$last;
