#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

saywrap(reorder("
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
"));

sub reorder($para0) {
  (my $para = $para0) =~ s/^\s*(.*?)\s*$/$1/;
  $para =~ s/\n/ /g;
  $para =~ s/\s{2,}/ /g;
  my @o;
  foreach my $s0 (split /[.?!] /, $para) {
    if ($s0) {
      my $s = $s0;
      $s =~ s/[^a-z]\s/ /gi;
      $s =~ s/\.$//g;
      $s =~ s/^\s*(.*?)\s*$/$1/;
      $s =~ s/\s{2,}/ /g;
      my @w = sort {lc($a) cmp lc($b)} split ' ',$s;
      push @o,join(' ',@w) . '.';
    }
  }
  return join(' ',@o);
}

sub saywrap($p0) {
  my $p = $p0;
  my $ll = 72;
  while (length($p) >= $ll) {
    my $c = $ll;
    while ($c > 0) {
      if (substr($p, $c, 1) eq ' ') {
        print substr($p, 0, $c),"\n";
        $p = substr($p, $c+1);
        $c = -1;
        last;
      }
      $c--;
    }
    if ($c == 0) {
      print substr($p, 0, $ll-1),"-\n";
      $p = substr($p, $ll);
    }
  }
  if (length($p) > 0) {
    print $p,"\n";
  }
}
