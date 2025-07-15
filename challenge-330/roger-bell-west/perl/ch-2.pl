#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(titlecapital('PERL IS gREAT'), 'Perl is Great', 'example 1');
is(titlecapital('THE weekly challenge'), 'The Weekly Challenge', 'example 2');
is(titlecapital('YoU ARE A stAR'), 'You Are a Star', 'example 3');

sub titlecapital($a) {
  my @out;
  foreach my $w (split ' ', $a) {
    my $p = lc($w);
    if (length($p) > 2) {
      $p = ucfirst($p);
    }
    push @out, $p;
  }
  join(' ', @out);
}
