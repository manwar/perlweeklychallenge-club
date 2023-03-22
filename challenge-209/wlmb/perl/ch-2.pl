#!/usr/bin/env perl
# Perl weekly challenge 209
# Task 2:  Merge Account
#
# See https://wlmb.github.io/2023/03/20/PWC209/#task-2-merge-account
use v5.36;
use English;
my %line_of;
my @names;
while(<>){
    chomp;
    my ($name, @addresses)=split / /;
    next unless $name; # skip empty lines
    $names[$INPUT_LINE_NUMBER]=$name;
    my ($merged)=grep {defined $_} map {$line_of{$_}} @addresses;
    $merged//=$INPUT_LINE_NUMBER; # current line by default
    @line_of{@addresses}=($merged) x @addresses;
}
my %accounts;
push @{$accounts{$line_of{$_}}}, $_ for(keys %line_of);
# Sort output by account name and line number, and sort addresses
say "$names[$_] ($_): ", join " ",
    sort {$a cmp $b} @{$accounts{$_}}
    for sort {$names[$a] cmp $names[$b] || $a <=>$b} keys %accounts;
