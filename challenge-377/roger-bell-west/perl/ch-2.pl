#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(prefixsuffix(['a', 'aba', 'ababa', 'aa']), 4, 'example 1');
is(prefixsuffix(['pa', 'papa', 'ma', 'mama']), 2, 'example 2');
is(prefixsuffix(['abao', 'abab']), 0, 'example 3');
is(prefixsuffix(['abab', 'abab']), 1, 'example 4');
is(prefixsuffix(['ab', 'abab', 'ababab']), 3, 'example 5');

sub prefixsuffix($a0) {
  my $tot = 0;
  my @a = sort {length($::a) <=> length($::b)} @{$a0};
  foreach my $si (0 .. $#a - 1) {
    foreach my $li ($si + 1 .. $#a) {
      if (index($a[$li], $a[$si]) == 0 &&
          rindex($a[$li], $a[$si]) == length($a[$li]) - length($a[$si])) {
        $tot += 1;
      }
    }
  }
  $tot;
}
