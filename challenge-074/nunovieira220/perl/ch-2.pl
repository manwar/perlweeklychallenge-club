#!/usr/bin/perl

use strict;
use warnings;

# Execute FNR
sub fnr {
  my @stack = ();
  my %aux = ();
  my $res = "";
  for my $i (0..length($_[0])-1) {
    my $c = substr($_[0], $i, 1);

    if(!$aux{$c}) {
      push(@stack, $c);
      $aux{$c} = 1;
      $res .= $c;
    } else {
      @stack = grep {!/$c/} @stack;
      if(scalar @stack > 0) {
        $res .= pop(@stack);
      } else {
        $res .= '#';
      }
    }
  }

  return $res;
}

# Input/Output
if(scalar @ARGV == 1) {
  print fnr($ARGV[0])."\n";
} else {
  print fnr("xyzzyx")."\n";
}