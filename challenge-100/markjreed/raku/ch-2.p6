#!/usr/bin/env raku
unit sub MAIN($triangle-array);

die "Illegal triangle array"
  if $triangle-array ~~ /<-[ \[ \] 0 .. 9 , \s ]>/;

use MONKEY-SEE-NO-EVAL;
my @array = EVAL $triangle-array;
my ($row, $col) = 0,0;
my $len = @array[$row][$col];

while ($row < @array - 1) {
  $row = $row+1;
  $col = ($col,$col+1).min( { @array[$row][$_] } );
  $len += @array[$row][$col];
}

say $len;
