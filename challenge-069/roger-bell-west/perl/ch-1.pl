#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(sg(50,100),
          [69,88,96],
          'example 1',
            );

sub sg {
  my @range=@_;
  my @out;
  my %charges=(
    6 => 9,
    9 => 6,
    8 => 8,
    0 => 0,
      );
  my $cm=join('',keys %charges);
 OUTER:
  foreach my $n ($range[0]..$range[1]) {
    if ($n !~ /^[$cm]*$/) {
      next;
    }
    if ($n =~ /0$/) {
      next;
    }
    my $nl=length($n)-1;
    my %locs;
    foreach my $pos (0..$nl) {
      $locs{$nl-$pos}=$charges{substr($n,$pos,1)};
    }
    foreach my $pos (keys %locs) {
      if (substr($n,$pos,1) ne $locs{$pos}) {
        next OUTER;
      }
    }
    push @out,$n;
  }
  return \@out;
}
