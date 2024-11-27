#! /usr/bin/env raku

subset POINT where { /^ \d+ \, \s? \d+ $/ };

unit sub MAIN (POINT $point1, POINT $point2, POINT $point3, :v(:$verbose));

my @point1 = $point1.split(/\,\s?/);
my @point2 = $point2.split(/\,\s?/);
my @point3 = $point3.split(/\,\s?/);

say ": Points: [{ @point1.join(",") }], [{ @point2.join(",") }], [{ @point3.join(",") }]" if $verbose;

my @vector12 = ( @point2[0] - @point1[0], @point2[1] - @point1[1] );
my @vector13 = ( @point3[0] - @point1[0], @point3[1] - @point1[1] );

say ": Vectors: [{ @vector12.join(",") }], [{ @vector13.join(",") }]" if $verbose;

if (@vector12[0] == @vector13[0] == 0 || @vector12[1] == @vector13[1] == 0)
{
  say ": Both vectors are on one of the axis, and thus equal)" if $verbose;
  say False;
  exit;
}

say ": Delta x: { @vector12[0] / @vector13[0] } { ( @vector12[0] / @vector13[0] == @vector12[1] / @vector13[1] ) ?? "==" !! "<>" } Delta y: { @vector12[1] / @vector13[1] }" if $verbose;

say ! (@vector12[0] / @vector13[0] == @vector12[1] / @vector13[1]);
