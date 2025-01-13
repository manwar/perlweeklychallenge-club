#!/usr/bin/env perl
# Perl weekly challenge 304
# Task 1:  Arrange Binary
#
# See https://wlmb.github.io/2025/01/13/PWC304/#task-1-arrange-binary
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV%2!=1;
    Usage: $0 N1 B1 N2 B2...
    to check if Ni 0's within the binary string Bi can be converted to 1's so that
    there are no consecutive 1's.
    FIN
for my($n,$b)(@ARGV){
    warn("String not binary: $b"), next unless $b=~/^[01]*$/;
    my $result= $b!~/11/ && test ($n,0,split"",$b);
    say "$n, $b -> ", $result? "True" : "False";
}

sub test($n,$m,@b){
    return 1 if $n<=0; # nothing to change
    return 0 if $m>=@b; # no more digits
    return test($n,$m+1,@b) if defined $b[$m+1] && $b[$m+1]==1; # b1bbb...->bbb...
    return test($n,$m+2,@b) if $b[$m]==1; # 10bbb...->bbb...
    return test($n-1, $m+2, @b); # 00bbb->10bbb->bbb
}
