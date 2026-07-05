#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 6;

sub prefix_suffix{
  my ($arr) = @_;
  my %h;
  foreach my $i(0..$#$arr){
    my $s1 = $arr->[$i];
    foreach my $j($i+1..$#$arr){
      my $s2 = $arr->[$j];
      next if 0 != index($s2,$s1)
	|| abs(length($s2) - length($s1)) != rindex $s2,$s1;
      undef $h{join ':',sort {$a <=> $b} $i,$j}
    }
  }
  scalar keys %h
}

is prefix_suffix(['a','aba','ababa','aa']),4,'Example 1';
is prefix_suffix(['pa','papa','ma','mama']),2,'Example 2';
is prefix_suffix(['abao','ab']),0,'Example 3';
is prefix_suffix(['abab','abab']),1,'Example 4';
is prefix_suffix(['ab','abab','ababab']),3,'Example 5';
is prefix_suffix(['abc','def','ghij']),0,'Example 6';

done_testing();

