#! /usr/bin/env raku

unit sub MAIN (:b(:$base10), :q(:$quater));

die "Specify one of 'base10' or 'quater'" unless one($base10, $quater);

say decimal-to-quater($base10) if $base10;
say quater-to-decimal($quater) if $quater;

sub quater-to-decimal ($number)
{
  my $decimal = 0;
  my $length  = $number.chars;
  
  for ^$length -> $d
  {
    $decimal += $number.substr($d, 1) * (2i ** --$length);
  }

  return $decimal ~~ /(.*)\+0i$/ ?? $decimal.Int !! $decimal;
}

sub decimal-to-quater ($number)
{
  die "Positive integers only, at this time" unless $number ~~ /^\d+$/;

  constant Schroeppel4 = 0xCCCCCCCC;

  return ( ($number + Schroeppel4 ) +^ Schroeppel4 ).base(4);
}
