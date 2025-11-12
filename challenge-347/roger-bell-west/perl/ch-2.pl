#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(formatphonenumber('1-23-45-6'), '123-456', 'example 1');
is(formatphonenumber('1234'), '12-34', 'example 2');
is(formatphonenumber('12 345-6789'), '123-456-789', 'example 3');
is(formatphonenumber('123 4567'), '123-45-67', 'example 4');
is(formatphonenumber('123 456-78'), '123-456-78', 'example 5');

sub formatphonenumber($a) {
  (my $p = $a) =~ s/\D+//g;
  my @pure = split '', $p;
  my $left = scalar @pure;
  my @out = ();
  my $i = 0;
  if ($left > 4) {
    foreach my $c (@pure) {
      push @out, $c;
      $i++;
      $left--;
      if ($i % 3 == 0) {
        push @out,'-';
        if ($left <= 4) {
          last;
        }
      }
    }
  }
  if ($left == 4) {
    push @out, $pure[$i];
    push @out, $pure[$i + 1];
    push @out, '-';
    $i += 2;
  }
  foreach my $p ($i .. $#pure) {
    push @out, $pure[$p];
  }
  join('', @out);
}
