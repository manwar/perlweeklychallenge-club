#! /usr/bin/env raku

say "  x|   1   2   3   4   5   6   7   8   9  10  11";
say "---+--------------------------------------------";

for 1 .. 11 -> $row
{
  print $row.fmt('%3d') ~ "|";
  print "    " x $row - 1;

  for $row .. 11 -> $col
  {
    print ($row * $col).fmt('%4d');
  }
  print "\n";
}
