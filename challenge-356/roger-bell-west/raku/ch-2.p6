#! /usr/bin/raku

use Test;

plan 5;

is(whowins('HAHAHH'), 'Team 2 defeated Team 6', 'example 1');
is(whowins('HHHHHH'), 'Team 1 defeated Team 2', 'example 2');
is(whowins('HHHAHA'), 'Team 4 defeated Team 2', 'example 3');
is(whowins('HAHAAH'), 'Team 4 defeated Team 6', 'example 4');
is(whowins('AAHHAA'), 'Team 6 defeated Team 1', 'example 5');

sub whowins($a) {
  my %round2 = SetHash.new;
  my %round3 = SetHash.new;
  for $a.comb.kv -> $i, $c {
    if ($i == 0) {
      if ($c eq 'H') {
        %round2{2} = 1;
      } else {
        %round2{7} = 1;
      }
    } elsif ($i == 1) {
      if ($c eq 'H') {
        %round2{3} = 1;
      } else {
        %round2{6} = 1;
      }
    } elsif ($i == 2) {
      if ($c eq 'H') {
        %round2{4} = 1;
      } else {
        %round2{5} = 1;
      }
    } elsif ($i == 3) {
      if ($c eq 'H') {
        %round3{1} = 1;
      } else {
        %round3{%round2.keys.max} = 1;
      }
    } elsif ($i == 4) {
      my @k = %round2.keys.sort;
      pop @k;
      if ($c eq 'H') {
        %round3{@k[0]} = 1;
      } else {
        %round3{@k[1]} = 1;
      }
    } elsif ($i == 5) {
      my @k = %round3.keys.sort;
      if ($c eq 'H') {
        return "Team @k[0] defeated Team @k[1]";
      } else {
        return "Team @k[1] defeated Team @k[0]";
      }
    }
  }
}
