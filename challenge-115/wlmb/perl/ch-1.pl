#!/usr/bin/env perl
# Perl weekly challenge 115
# Task 1: String Chain
#
# See https://wlmb.github.io/2021/06/01/PWC115/#task-1-string-chain
use strict;
use warnings;
use v5.12;
use List::Util qw(reduce);
use PDL;

my @strings=@ARGV;
die "Usage ./ch-1.pl string1 [string2...]" unless @strings;
my $C=zeroes(long,scalar(@strings), scalar(@strings)); #connectivity matrix
map {my $f=$_;map {$C->slice("$f,$_").=follows($f, $_)}
    (0..@strings-1)}(0..@strings-1);
my $R=reduce {map{$_->diagonal(0,1).=0}($a,$b); $b x $a;}
             ($C) x @strings;
say "Input: ", join " ", @strings;
say "Output: ", all($R->diagonal(0,1)>0);
sub follows {
    my ($from, $to)=map {$strings[$_]} @_;
    return substr($from,-1,1) eq substr($to,0,1);
}
