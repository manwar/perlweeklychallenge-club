#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $F = "input.txt";
my $N = 4;

# Output
say(readN($F, $N));

# Read N-characters
sub readN {
  my ($F, $N) = @_;
  my $res = "";

  open(my $fh, '<', $F) or die $!;

  while (my $read = read $fh, my $c, $N) {
    $res = $c;
    last;
  }

  close($fh); # Close file handler

  return $res;
}
