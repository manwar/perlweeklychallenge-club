#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(goalparser('G()(al)'), 'Goal', 'example 1');
is(goalparser('G()()()()(al)'), 'Gooooal', 'example 2');
is(goalparser('(al)G(al)()()'), 'alGaloo', 'example 3');
is(goalparser('()G()G'), 'oGoG', 'example 4');
is(goalparser('(al)(al)G()()'), 'alalGoo', 'example 5');

sub goalparser($a) {
  my $out = "";
  my $s = 0;
  while ($s < length($a)) {
    if (substr($a, $s) =~ /^G/) {
      $s += 1;
      $out .= "G";
    } elsif (substr($a, $s) =~ /^\(\)/) {
      $s += 2;
      $out .= "o";
    } elsif (substr($a, $s) =~ /^\(al\)/) {
      $s += 4;
      $out .= "al";
    } else {
      return "";
    }
  }
         $out;
       }
