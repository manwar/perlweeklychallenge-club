#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(specialbinarysubstrings('0101'), ['01', '10', '01'], 'example 1');
is_deeply(specialbinarysubstrings('000111'), ['000111', '0011', '01'], 'example 2');
is_deeply(specialbinarysubstrings('000011'), ['0011', '01'], 'example 3');
is_deeply(specialbinarysubstrings('10011100'), ['10', '0011', '01', '1100', '10'], 'example 4');
is_deeply(specialbinarysubstrings('00000'), [], 'example 5');

sub specialbinarysubstrings($a) {
  my @out;
  my @ac = split '', $a;
  foreach my $i (0 .. $#ac - 1) {
    for (my $j = $i + 1; $j <= $#ac; $j += 2) {
      my $lastchar = 'x';
      my $switches = 0;
      my $balance = 0;
      my $outstr = '';
      foreach my $ct ($i .. $j) {
        if ($ac[$ct] ne $lastchar) {
          $switches += 1;
          $lastchar = $ac[$ct];
        }
        if ($ac[$ct] eq '0') {
          $balance--;
        } else {
          $balance++;
        }
        $outstr .= $ac[$ct];
      }
      if ($balance == 0 && $switches == 2) {
        push @out, $outstr;
      }
    }
  }
  \@out;
}
