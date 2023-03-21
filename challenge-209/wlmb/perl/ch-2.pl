#!/usr/bin/env perl
# Perl weekly challenge 209
# Task 2:  Merge Account
#
# See https://wlmb.github.io/2023/03/20/PWC209/#task-2-merge-account
use v5.36;
use English;
my %merge_to;
my %line_of;
my @names;
while(<>){
    chomp;
    my ($name, @addresses)=split / /;
    $names[$INPUT_LINE_NUMBER] = $name;
    $merge_to{$INPUT_LINE_NUMBER}=$INPUT_LINE_NUMBER; # merge to itself
    for(@addresses){
	my $l=$line_of{$_};
	$line_of{$_}=$INPUT_LINE_NUMBER;
        # merge overlapping accounts with current one
	$merge_to{$l}=$merge_to{$merge_to{$l}}=$INPUT_LINE_NUMBER if defined $l;
    }
}
my @addresses = keys %line_of;                    # distinct addresses
my %merged;                                       # merged accounts
push @{$merged{$merge_to{$line_of{$_}}}}, $_      # add addresses to merged accounts
    for @addresses;
# output account name, (one of its) line number(s), addresses
say join " ", $names[$_], "($_):", sort {$a cmp $b} @{$merged{$_}}
    for sort {$names[$a] cmp $names[$b] || $a <=> $b} keys %merged;
