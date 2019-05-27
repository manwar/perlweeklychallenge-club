use 5.010.1;

use strict;
use warnings;

my %roman = reverse qw/
  I 1
  V 5
  X 10
  L 50
  C 100
  D 500
  M 1000
/;

# === MAIN ===
say encode(2019);
# ============

sub encode {
  # "additive" notation
  # https://en.wikipedia.org/wiki/Roman_numerals#Use_of_additive_notation
  
  my $integer = shift;
  my @r;

  ROMAN:
  for ( sort { $b <=> $a } keys %roman ) {
    push @r, $roman{$_} x int $integer / $_;

    $integer %= $_;
  }

  join '', @r;
}

sub decode {}
