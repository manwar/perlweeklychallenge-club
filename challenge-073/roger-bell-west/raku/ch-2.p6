#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(sn((7,8,3,12,10)),
          (0,7,0,3,3),
          'example 1',
            );
is-deeply(sn((4,6,5)),
          (0,4,4),
          'example 2',
            );

sub sn(@a) {
  my @out=(0);
  my $wm;
  for (1..@a.end) -> $i  {
    if (!defined $wm) {
      $wm=@a[$i-1];
    } else {
      $wm=min($wm,@a[$i-1]);
    }
    if ($wm < @a[$i]) {
      push @out,$wm;
    } else {
      push @out,0;
    }
  }
  return @out.flat;
}
