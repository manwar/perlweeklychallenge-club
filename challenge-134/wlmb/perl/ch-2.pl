#!/usr/bin/env perl
# Perl weekly challenge 134
# Task 2:  Distinct Terms Count
#
# See https://wlmb.github.io/2021/10/11/PWC134/#task-2-distinct-terms-count
use v5.12;
use warnings;
use PDL;
use List::Util qw(uniqint);
say "Usage: ./ch-2.pl N M" and exit unless @ARGV==2;
my ($m, $n)=@ARGV;
my $table=(zeroes($n,$m)->ndcoords+1)->prodover;
my $uniq=$table->uniq;
my $count=$uniq->nelem;
say "Input: m=$m, n=$n";
say "Output: $table"; # Could have done a better format
say "Distinct terms: $uniq\nCount: $count;"
