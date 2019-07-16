#! /usr/bin/env perl6

use Digest::SHA;  # zef install Digest

subset BitcoinAddress of Str where  26 <= .chars <= 35 && /^ <[1..9 A..Z a..z]-[IOl]>+$/ && /^[1|3|bc1]/;

my @alphabet = (1..9, "A".."H", "J".."N", "P".."Z", "a".."k", "m".."z").flat;

my %values = @alphabet.map( { $_ => $++ } );
my $alphabet-length = @alphabet.elems;

multi MAIN (BitcoinAddress $bca)
{
  my @values = from-baseX($bca, $alphabet-length).polymod(256 xx 24).reverse;
  my @check  = @values[21..24];
  my @sha    = sha256(sha256(Buf.new(@values[^21]))).list[^4];

  @sha eqv @check
    ?? say "Valid"
    !! say "Not valid";
}

multi MAIN (Str $string)
{
  say "Not valid";
}

sub from-baseX (Str $value, Int $base = 42)
{
  my $return = 0;
  my $exp    = 0;

  for $value.flip.comb -> $digit
  {
    $return += %values{$digit} * $base ** $exp++;
  }
  return $return;
}
