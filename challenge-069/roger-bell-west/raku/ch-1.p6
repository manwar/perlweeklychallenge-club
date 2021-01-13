#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(sg(50,100),
          [69,88,96],
          'example 1',
            );

sub sg ($a,$b) {
  my @out;
  my %charges=(
    6 => 9,
    9 => 6,
    8 => 8,
    0 => 0,
      );
  my $cm='^<[' ~ %charges.keys.join('') ~ ']>*$';
  for $a..$b -> $n {
    if ($n !~~ /<$cm>/) {
      next;
    }
    if ($n ~~ /0$/) {
      next;
    }
    my $nl=chars($n)-1;
    my %locs;
    for 0..$nl -> $pos {
      %locs{$nl-$pos}=%charges{substr($n,$pos,1)};
    }
    my $nn=$n;
    for keys %locs -> $pos {
      if (substr($n,$pos,1) ne %locs{$pos}) {
        $nn=-1;
        last;
      }
    }
    if ($nn>=0) {
      push @out,$nn;
    }
  }
  return @out;
}
