#! /usr/bin/env raku

subset CHESSPOS where /^ <[a..h]> <[1..8]> $/;

unit sub MAIN (CHESSPOS $c1, CHESSPOS $c2, :v(:$verbose));

my $colour_c1 = colour($c1);
my $colour_c2 = colour($c2);

say ":C1: $colour_c1\n:C2: $colour_c2" if $verbose;

say $colour_c1 eq $colour_c2;

sub colour (CHESSPOS $pos)
{
  my ($col, $row) = $pos.comb;

  my $magic = ($col.ord - 'a'.ord + $row) % 2;

  return $magic ?? "B" !! "W";
}