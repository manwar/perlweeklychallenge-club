#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross']), 1, 'example 1');
is(secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar']), 1, 'example 2');

sub secretsanta($name) {
  my @family;
  foreach my $n (@{$name}) {
    push @family, (split(' ', $n))[-1];
  }
  my %receivers = map {$_ => 1} (0 .. $#{$name});
  my @gifting;
  foreach my $giver (0 .. $#{$name}) {
    my $done = 0;
    my $r = 0;
    foreach my $recipient (keys %receivers) {
      if ($family[$giver] ne $family[$recipient]) {
        $r = $recipient;
        $done = 1;
        last;
      }
    }
    if (!$done) {
      foreach my $recipient (keys %receivers) {
        if ($recipient != $giver) {
          $r = $recipient;
          last;
        }
      }
    }
    delete $receivers{$r};
    push @gifting, [$name->[$giver], $name->[$r]];
  }
  foreach my $p (@gifting) {
    print("$p->[0] -> $p->[1]\n");
  }
  print "\n";
  return 1;
}
