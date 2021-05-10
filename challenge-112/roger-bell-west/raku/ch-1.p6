#! /usr/bin/perl6

use Test;

plan 4;

is(cp('/a/'),'/a','example 1');
is(cp('/a/b//c/'),'/a/b/c','example 2');
is(cp('/a/b/c/../..'),'/a','example 3');
is(cp('/a/./b'),'/a/b','example 4');

sub cp($i) {
  my @p=$i.split('/').grep(/./).grep({$_ ne '.'});
  my $d=1;
  while ($d) {
    $d=0;
    for 1..@p.elems-1 -> $pi {
      if (@p[$pi] eq '..') {
        splice @p,$pi-1,2;
        $d=1;
        last;
      }
    }
  }
  return '/' ~ join('/',@p);
}
