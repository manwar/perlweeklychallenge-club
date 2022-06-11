#! /usr/bin/env raku

unit sub MAIN ($string, :v(:$verbose));

my ($Ax1, $Ay1, $Ax2, $Ay2, $Bx1, $By1, $Bx2, $By2) = $string.words>>.Numeric;

my $A-area = ($Ax2 - $Ax1).abs * ($Ay2 - $Ay1).abs;
my $B-area = ($Bx2 - $Bx1).abs * ($By2 - $By1).abs;

my $x-dist = min($Ax2, $Bx2) - max($Ax1, $Bx1);
my $y-dist = min($Ay2, $By2) - max($Ay1, $By1);

my $i-area = ($x-dist > 0 && $y-dist > 0) ?? $x-dist * $y-dist !! 0;

if $verbose
{
  say ": First rectangle has area: $A-area";
  say ": Second rectangle has area: $B-area";
  say ": Intersection has area: $i-area";
}

say $A-area + $B-area - $i-area;