#!/usr/bin/env perl
# Perl weekly challenge 159
# Task 1: Farey sequence
#
# See https://wlmb.github.io/2022/04/05/PWC159/#task-1-farey-sequence
use v5.12;
use warnings;
use POSIX qw(floor);
use Text::Wrap qw(wrap $columns $break);
die "Usage: ./ch-1.pl N1 [N2... ]\n to print Farey sequences of order N1, N2..." unless @ARGV;
for(@ARGV){
    my @farey=([0,1],[1,$_]);
    while($farey[-1][1]!=1){
        my ($a,$b,$c,$d)=(@{$farey[-2]}, @{$farey[-1]});
        my $k=floor(($_+$b)/$d);
	push @farey, [$k*$c-$a, $k*$d-$b];
    }
    $columns=62; $break=qr/\s/;
    say "Input: $_\n",wrap("", "        ", "Output: ",
	join ", ",
	map {"$_->[0]/$_->[1]"} @farey);
}
