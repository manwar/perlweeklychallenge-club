#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(countvowel('aeiou'), ['aeiou'], 'example 1');
is_deeply(countvowel('aaeeeiioouu'), ['aeeeiioou'], 'example 2');
is_deeply(countvowel('aeiouuaxaeiou'), ['aeiou', 'aeiou', 'eiouua'], 'example 3');
is_deeply(countvowel('uaeiou'), ['aeiou', 'uaeio'], 'example 4');
is_deeply(countvowel('aeioaeioa'), [], 'example 5');

sub countvowel($a0) {
  my @a = split '', $a0;
  my @found;
  my $l = scalar @a;
  foreach my $start (reverse (0 .. $l - 5)) {
  END:
    foreach my $eend ($start + 5 .. $l) {
      my %sample = map {$_ => 1} @a[$start..$eend - 1];
      foreach my $c (qw(a e i o u)) {
        unless (exists $sample{$c}) {
          next END;
        }
        delete $sample{$c};
      }
      if (scalar keys %sample == 0) {
        push @found, join('', @a[$start .. $eend-1]);
        $l = $eend - 1;
        last;
      }
    }
  }
  @found = sort @found;
  \@found;
}
