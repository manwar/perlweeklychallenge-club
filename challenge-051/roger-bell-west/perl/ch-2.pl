#! /usr/bin/perl

use strict;
use warnings;

use integer;

use List::Util qw(max);

foreach my $a (2..9) { # 1?? will never be colourful
  foreach my $b (2..9) { # ?0? and ?1? will never be colourful
    if ($a==$b) {
      next;
    }
    foreach my $c (2..9) { # ??0 and ??1 will never be colourful
      if ($a==$c || $b==$c) {
        next;
      }
      my %p;
      $p{$a}++;
      $p{$b}++;
      $p{$c}++;
      $p{$a*$b}++;
      $p{$b*$c}++;
      $p{$a*$b*$c}++;
      if (max(values %p) < 2) {
        print "$a$b$c\n";
      }
    }
  }
}
