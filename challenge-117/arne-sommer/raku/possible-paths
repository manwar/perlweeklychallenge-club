#! /usr/bin/env raku

unit sub MAIN (Int $N where $N >= 1, :v(:$verbose));

my $seq := gather
{
  traverse(0, 0, "", $N);

  sub traverse ($row, $col, $path, $size)
  {
    return take $path if $row == $col == $size;

    traverse($row,    $col +1, $path ~ "H", $size) if $col < $row;
    traverse($row +1, $col +1, $path ~ "R", $size) if $col < $size;
    traverse($row +1, $col,    $path ~ "L", $size) if $row < $size;

  }
}

say ": Number of paths: { $seq.elems } " if $verbose;

say $seq.join(", ");

