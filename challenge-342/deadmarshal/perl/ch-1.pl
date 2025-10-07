#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub balance_string{
  my @chars = split '',$_[0];
  my @ds = grep{/\d/} @chars;
  my @ls = grep{/\D/} @chars;
  my ($m,$n) = (scalar @ds,scalar @ls);
  return '' if abs($m-$n) > 1;
  my $res;
  foreach my $i(0..min($m,$n)-1){
    if($m > $n) {
      $res .= $ds[$i] . $ls[$i]
    } else {
      $res .= $ds[$i] . $ls[$i]
    }
  }
  $res .= $ds[$m-1] if($m > $n);
  $res .= $ls[$n-1] if($m < $n);
  $res
}

printf "%s\n",balance_string('a0b1c2');
printf "%s\n",balance_string('abc12');
printf "%s\n",balance_string('0a2b1c3');
printf "%s\n",balance_string('1a23');
printf "%s\n",balance_string('ab123')

