#!/usr/bin/env perl
# Perl weekly challenge 220
# Task 1:  Common Characters
#
# See https://wlmb.github.io/2023/06/05/PWC220/#task-1-common-characters
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2...]
    to return the sorted list of characters common to the words W1 W2...
    FIN
use List::Util qw(uniq);
my %seen;
for(@ARGV){
    $seen{$_}++ for uniq split "", lc
}
my $N=@ARGV;
my @result=sort {$a cmp $b} grep {$seen{$_}==$N} keys %seen;
say "@ARGV -> @result"
