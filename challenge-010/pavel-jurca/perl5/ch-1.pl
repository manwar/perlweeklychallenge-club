use 5.010.1;
 
use strict;
use warnings;
 
my %roman = reverse qw/
  I   1
  IV  4
  V   5
  IX  9
  X  10
  XL 40
  L  50
  XC 90
  C  100
  CD 400
  D  500
  CM 900
  M  1000
/;
 
# === MAIN ===
# See Also
# https://en.wikipedia.org/wiki/Roman_numerals#Use_of_additive_notation
 
say encode($_) for qw/2019 495 246 99 39/;
say decode($_) for qw/MMXIX CDXCV CCXLVI XCIX XXXIX/;
# ============
 
sub encode {
  my $num = shift;
  my @str;
 
  TO_ROMAN:
  for ( sort { $b <=> $a } keys %roman ) {
    push @str, $roman{$_} x int $num / $_;
 
    $num %= $_;
  }
 
  @str # roman numeral
}
 
sub decode {
  my $str = shift;
  my $num;
 
  TO_ARABIC:
  for ( sort { $b <=> $a } keys %roman ) {
    $num += $_ while ($str =~ s/^$roman{$_}//);
  }
 
  $num # arabic numeral
}
 
 
# === OUTPUT ===
 
# $ time perl ch-1.pl
# MMXIX
# CDXCV
# CCXLVI
# XCIX
# XXXIX
# 2019
# 495
# 246
# 99
# 39
#
# real    0m0.005s
# user    0m0.004s
# sys     0m0.001s
