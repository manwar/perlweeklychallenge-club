#!/usr/bin/env perl
use strict;
use warnings;

sub changing_keys{
  my ($c,@arr) = (0,split '',lc $_[0]);
  foreach my $i(0..$#arr-1){
    $c++ if $arr[$i] ne $arr[$i+1]
  }
  $c
}

printf "%d\n",changing_keys('pPeERrLl');
printf "%d\n",changing_keys('rRr');
printf "%d\n",changing_keys('GoO');

