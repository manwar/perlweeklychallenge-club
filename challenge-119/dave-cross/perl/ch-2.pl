#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $n = get_number();

my @seq;

while (@seq < $n) {
  get_next(\@seq);
}

say $seq[-1];

sub get_next {
  my ($seq) = @_;

  unless (@$seq) {
    @$seq = 1;
    return;
  }

  my $next = $seq->[-1] + 1;

  until ($next =~ /^[123]+$/ and $next !~ /11/) {
    ++$next;
  }
  
  push @$seq, $next;

  return;
}

sub get_number {
  my $err = "Give me an integer\n";

  die $err unless @ARGV;
  die $err if $ARGV[0] =~ /\D/;

  return $ARGV[0];
}
