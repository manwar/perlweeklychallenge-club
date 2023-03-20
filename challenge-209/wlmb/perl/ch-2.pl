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
    for(@addresses){
	$merge_to{$INPUT_LINE_NUMBER} =
	    defined $merge_to{$line_of{$_}}
	        ?$merge_to{$line_of{$_}}          # previously merged
	        :$line_of{$_}                     # or first time merge
            if defined $line_of{$_};              # address has been seen before
        $line_of{$_}//=$INPUT_LINE_NUMBER;        # map to current line if not seen before
    }
    $merge_to{$.}//=$INPUT_LINE_NUMBER;           # merge to itself if not already merged
}
my @addresses = keys %line_of;                    # distinct addresses
my %merged;                                       # merged accounts
push @{$merged{$merge_to{$line_of{$_}}}}, $_      # add addresses to merged accounts
    for @addresses;
# output account name, (one of its) line number(s), addresses
say join " ", $names[$_], "($_):", sort {$a cmp $b} @{$merged{$_}}
    for sort {$names[$a] cmp $names[$b] || $a <=> $b} keys %merged;
