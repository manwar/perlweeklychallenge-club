#!/usr/bin/env perl
# Perl weekly challenge 211
# Task 2:  Split Same Average
#
# See https://wlmb.github.io/2023/04/03/PWC211/#task-2-split-same-average
use v5.36;
use Algorithm::Combinatorics qw(subsets);
use List::Util qw(sum);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to test if the set N1 N2... may be split into two proper subsets
    with the same average
    FIN
my $avg=sum(@ARGV)/@ARGV;
my $subsets=subsets(\@ARGV);
$subsets->next; # Throw away the complete set
my $candidate;
while($candidate=$subsets->next){
    next if @$candidate==0;  # Throw away the empty set
    last if sum(@$candidate)==$avg*@$candidate; # success
}
say("@ARGV -> ", $candidate && @$candidate? "True: @$candidate" : "False")
