#!/use/bin/perl

use strict;
use warnings;
use feature 'say';

my $n = get_arg();

my $count = get_set_bits($n);

while (1) {
  $n++;

  if (get_set_bits($n) == $count) {
    say $n;
    last;
  }
}

sub get_arg {
  if (!@ARGV or $ARGV[0] =~ /\D/) {
    die "Give me a positive integer\n";
  }

  return $ARGV[0];
}

sub get_set_bits {
  my ($dec) = @_;

  my $bin = sprintf '%b', $dec;

  return scalar $bin =~ tr/1//;
}
