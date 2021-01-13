#!/usr/bin/perl

# Perl Weekly Challenge - 063
#
# Task 1 - Last Word
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Prototype
sub last_word($$);

printf "%s\n", last_word('  hello world',                qr/[ea]l/);      # 'hello'
printf "%s\n", last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
printf "%s\n", last_word("spaces in regexp won't match", qr/in re/) // '(undef)';      #  undef
printf "%s\n", last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

sub last_word ($$) {
  my ($line, $re) = @_;

  foreach my $word (reverse split(/\s+/, $line) {
     return $word if ($word =~ /$re/);
  }

  return undef;
}

