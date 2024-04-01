#!/usr/bin/env perl
# Perl weekly challenge 263
# Task 2:  Merge Items
#
# See https://wlmb.github.io/2024/04/01/PWC263/#task-2-merge-items
use v5.36;
use PDL; # use the perl data language to convert the input to a list of keys-values
use experimental qw(for_list); # use for list to process key-value pairs
die <<~"FIN" unless @ARGV;
    Usage: $0 "[[K11,V11],[K12,V12]...]]" "[[K21,V21],[K22,V22],...]" ...
    to accumulate all values Vij corresponding to each unique key Kn=Kij
    FIN
my @keyvals;
push @keyvals, pdl($_)->list for @ARGV;
my %merged;
for my($key, $val)(@keyvals){
    $merged{$key}+=$val
};
my @result = map {"[$_,$merged{$_}]"} sort {$a cmp $b} keys %merged;
say "@ARGV -> [@result]";
