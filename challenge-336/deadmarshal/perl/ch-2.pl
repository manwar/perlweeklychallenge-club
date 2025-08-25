#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub final_score{
  my @stk;
  for(@{$_[0]}) {
    if(/\d+/) {
      push @stk,$_
    } elsif($_ eq 'C') {
      pop @stk
    } elsif($_ eq 'D') {
      push @stk,$stk[-1] * 2
    } else {
      push @stk,$stk[-2] + $stk[-1]
    }
  }
  sum0 @stk
}

printf "%d\n",final_score(['5','2','C','D','+']);
printf "%d\n",final_score(['5','-2','4','C','D','9','+','+']);
printf "%d\n",final_score(['7','D','D','C','+','3']);
printf "%d\n",final_score(['-5','-10','+','D','C','+']);
printf "%d\n",final_score(['3','6','+','D','C','8','+','D',
			   '-2','C','+']);

