#!/usr/bin/env perl

use v5.36;
use builtin qw(indexed);

our @TESTS = (
  ['1ac2.34f0.b1c2', '1a:c2:34:f0:b1:c2'],
  ['abc1.20f1.345a', 'ab:c1:20:f1:34:5a'],
);


sub convert_mac_address($addr) {
  my @pairs = grep { length } split(/(..)/, $addr =~ s/\.//gr);
  join ':', @pairs;
}


sub main($args) {
  foreach my $addr ($args->@*) {
    say convert_mac_address($addr);
  }
}


sub test() {
  use builtin qw(indexed);
  use experimental qw(for_list);
  use Test2::V0;
  no warnings qw(experimental);

  plan scalar @TESTS;

  foreach my ($i, $case) (indexed @TESTS) {
    my ($input, $expected) = $case->@*;
    is convert_mac_address($input), $expected, 'Test ' . ++$i;
  }
}


exit test() if (@ARGV && $ARGV[0] eq '--test');
exit main(@ARGV and \@ARGV or [map { $_->[0] } @TESTS]);
