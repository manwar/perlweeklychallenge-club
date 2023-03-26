#!/usr/bin/env perl
# Perl weekly challenge 209
# Task 2:  Merge Account
#
# See https://wlmb.github.io/2023/03/20/PWC209/#task-2-merge-account
use v5.36;
use English;
use List::Util qw(uniq);
my %line_of;
my %addresses_of;
my @names;
while(<>){
    chomp;
    # Assume input is of the form: name address1 address2...
    my ($name, @addresses)=split ' ';
    next unless $name; # skip empty lines
    $names[$INPUT_LINE_NUMBER]=$name;
    my @merged=grep {defined $_} map {$line_of{$_}} @addresses; # lines to merge with current
    push @addresses, map {@{$addresses_of{$_}}} @merged;        # add their addresses
    @addresses=uniq @addresses;                                 # avoid repetitions
    delete $addresses_of{$_} for @merged;                       # delete merged lines
    @line_of{@addresses}=($INPUT_LINE_NUMBER) x @addresses;     # map addresses to line
    $addresses_of{$INPUT_LINE_NUMBER}=[@addresses];             # map line to addresses
}
# Output. Sort by account name and line number, and sort addresses
say "$names[$_] ($_): ", join " ",
    sort {$a cmp $b} @{$addresses_of{$_}}
    for sort {$names[$a] cmp $names[$b] || $a <=>$b} keys %addresses_of;
