#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(sum max);

sub longestabsolutepath($fs) {
  my @components;
  my $maxlen = 0;
  foreach my $entry (split /\\n/, $fs) {
    my @parts = split /\\t/, $entry;
    my $depth = scalar @parts;
    while (scalar @components < $depth) {
      push @components, 0;
    }
    while (scalar @components >= $depth) {
      pop @components;
    }
    push @components, length($parts[-1]);
    if (index($parts[-1], '.') > -1) {
      $maxlen = max($maxlen, sum(@components) + scalar @components - 1);
    }
  }
  $maxlen;
}

use Test::More tests => 5;

is(longestabsolutepath('dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2'), 0, 'example 1');
is(longestabsolutepath('file1.txt\nfile2.ext\na.png'), 9, 'example 2');
is(longestabsolutepath('my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png'), 38, 'example 3');
is(longestabsolutepath('root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt'), 14, 'example 4');
is(longestabsolutepath('a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt'), 32, 'example 5');
