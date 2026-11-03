#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub string_difference{
  my ($words) = @_;
  my (@keys,%h);
  foreach my $w(@$words){
    my @ord = map {ord($_) - ord('a')} split '',$w;
    my $key = join ',',map{$ord[$_+1] - $ord[$_]} 0..$#ord-1;
    push @keys,$key;
    $h{$key}++
  }
  foreach my $i(0..$#$words){
    return $words->[$i] if $h{$keys[$i]} == 1;
  }
  return -1
}

is string_difference(['ab','bc','cd','zy']),'zy','Example 1';
is string_difference(['cba','fed','azy']),'azy','Example 2';
is string_difference(['pop','ada','beb','cfc']),'pop','Example 3';
is string_difference(['aaaa','zzzz','mmmm','aaba']),'aaba','Example 4';
is string_difference(['aceg','bdfh','cegi','azbz']),'azbz','Example 5';

