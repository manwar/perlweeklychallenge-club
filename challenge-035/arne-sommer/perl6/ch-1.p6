#! /usr/bin/env raku

use lib "lib";

use BinaryMorse2;

multi sub MAIN (BinaryMorse2::BinaryMorse $binary-morse)
{
  say BinaryMorse2::demorsify($binary-morse);
}

multi sub MAIN (:$binary where $binary.IO.f && $binary.IO.r)
{
  my $fh = open $binary, :bin;
  my $data = $fh.read;
  $fh.close;

  my $result = "";
  $result ~= $_.base(2).fmt("%08d") for @($data);

  $result.substr-rw(0,1) = "" while $result.chars && $result.substr(0,1) eq "0";
  
  say BinaryMorse2::demorsify($result);
}

multi sub MAIN (Str $text, :$roundtrip, :$binary)
{
  if $binary
  {
    if my $fh = open $binary, :w, :bin
    {
      my @values = BinaryMorse2::morsify($text).parse-base(2).polymod(256 xx 200).reverse;
      @values.shift while @values && @values[0] == 0;
      die "Set a higher polymod value" if @values[0] > 255;
      $fh.write: Blob.new(@values);
      $fh.close;

      MAIN(:$binary) if $roundtrip;
    }
    else
    {
      die "Unable to open file $binary";
    }
  }
  
  else
  {
    my $encoded = BinaryMorse2::morsify($text);
    say $encoded;
    say BinaryMorse2::demorsify($encoded) if $roundtrip;
  }
}
