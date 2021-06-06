#!/usr/bin/env perl
# Perl weekly challenge 115
# Task 1: String Chain. Königsberg bridges solution
#
# See https://wlmb.github.io/2021/06/01/PWC115/#task-1-string-chain
use strict;
use warnings;
use v5.12;
use Exporter::Renaming; # prevent name clashes
use List::Util Renaming=>[uniq=>'lu_uniq', reduce=>'lu_reduce', reductions=>undef];
use PDL;
use PDL::NiceSlice;

my @strings=@ARGV;
die "Usage ./ch-1.pl string1 [string2...]" unless @strings;
my @letters=lu_uniq map{(substr($_,0,1), substr($_,-1,1))} @strings;
my %index;
@index{@letters}=(0..@letters-1);
my $C=zeroes(scalar(@letters), scalar(@letters)); #connectivity matrix
$C->($_->[0],$_->[1]).=$C->($_->[0],$_->[1])+1
    foreach map { [$index{substr($_,0,1)},$index{substr($_,-1,1)}] } @strings;
my $balanced=all($C->sumover==$C->transpose->sumover);
my $final=lu_reduce {$a|$b} (reductions {$a x $b} (identity(scalar @letters), ($C) x (@letters-1)));
my $reachable=all($final!=0);
say "Input: ", join " ", @strings;
say "Output: ", $balanced &&$reachable? 1:0;
