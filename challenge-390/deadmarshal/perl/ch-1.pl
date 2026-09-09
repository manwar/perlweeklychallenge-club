#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub decode_string{
  my (@s1,@s2);
  my $num = 0;
  my $res = '';
  foreach my $c(split '',$_[0]){
    if($c =~ /\d/) {
      $num = $num * 10 + $c - '0'
    } elsif($c eq '[') {
      push @s1,$num;
      push @s2,$res;
      $num = 0;
      $res = ''
    } elsif($c eq ']') {
      my $t = '';
      for(my ($i,$n) = (0,pop @s1); $i < $n; ++$i) {
	$t .= $res
      }
      $res = (pop @s2) . $t
    } else {
      $res .= $c
    }
  }
  $res
}

is decode_string('2[3[a]]'),'aaaaaa','Example 1';
is decode_string('10[a]'),'aaaaaaaaaa','Example 2';
is decode_string('a2[b]c3[d]e'),'abbcddde','Example 3';
is decode_string('2[a2[b]c]'),'abbcabbc','Example 4';
is decode_string('1[a]2[b3[c]]'),'abcccbccc','Example 5';

done_testing();

