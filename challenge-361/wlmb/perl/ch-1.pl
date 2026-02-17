#!/usr/bin/env perl
# Perl weekly challenge 361
# Task 1:  Zeckendorf Representation
#
# See https://wlmb.github.io/2026/02/16/PWC361/#task-1-zeckendorf-representation
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the Zeckendorf representation of the numbers Nn
    FIN
my @Fibonacci=(1,1); # known Fibonacci numbers
for(@ARGV){
    warn("Expected argument>1: $_"), next unless $_>=1;
    # Grow the list of Fibonacci numbers as needed
    push @Fibonacci, $Fibonacci[-1] + $Fibonacci[-2] while $Fibonacci[-1] < $_;
    say "$_ -> ", join "+", @{zeckendorf($_, 1, [])};
}

sub zeckendorf($target, $i, $results){
    return $results if $target==0;
    ++$i while $Fibonacci[-$i] > $target;
    my $found=$Fibonacci[-$i];
    push @$results, $found;
    return zeckendorf($target-$found, ++$i, $results);
}
