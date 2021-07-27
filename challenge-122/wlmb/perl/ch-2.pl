#!/usr/bin/env perl
# Perl weekly challenge 122
# Task 2:
#  Basketball Points
# See https://wlmb.github.io/2021/07/19/PWC122/#task-2-basketball-points
use strict;
use warnings;
use v5.12;
use Memoize;
memoize("points");

foreach (@ARGV){
    say "Input: $_\nOutput:\n\t", join "\n\t", map {join " ", @$_} points($_);
}
sub points{
    my $s=shift;
    return ()  if $s<=0;
    # Append a 1, 2 or 3 point throw to the previous points
    my @result=((map {my @x=@$_;push @x,1; [@x]}points($s-1)),
		(map {my @x=@$_;push @x,2; [@x]}points($s-2)),
		(map {my @x=@$_;push @x,3; [@x]}points($s-3)));
    push @result, [$s] if $s<=3;
    return @result;
}
