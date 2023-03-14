#!/usr/bin/env perl
# Perl weekly challenge 208
# Task 1:  Minimum Index Sum
#
# See https://wlmb.github.io/2023/03/13/PWC208/#task-1-minimum-index-sum
use v5.36;
use List::UtilsBy qw(nsort_by);
use feature qw(refaliasing declared_refs);
no warnings qw(experimental::refaliasing experimental::declared_refs);
die <<~"FIN" unless @ARGV==2;
    Usage: $0 S1 S2
    to find the common space separated substrings of S1 and S2 with the minimum index sum
    FIN
my (\@list1, \@list2)=map {[split " "]} @ARGV; # Save a couple of $'s
my (%list1, %list2);
@list1{@list1} = (0..@list1-1);
@list2{@list2} = (0..@list2-1);
my $smallest;
my @results = map {$_->[0]}                   # extract string part
              grep {
	          $smallest//=$_->[1];        # initialize with lowest index sum
		  $smallest==$_->[1]          # compare index sum with lowest
              }
              nsort_by {$_->[1]}              # sort by index sums
              map {
                  [$_, $list1{$_}+$list2{$_}] # [string, index sum]
              }
              grep {defined $list2{$_}}       # common strings go through
              keys %list1;
say "(@list1), (@list2) -> (@results)";       # print result
