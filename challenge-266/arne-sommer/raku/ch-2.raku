#! /usr/bin/env raku

unit sub MAIN ($string = "1 0 0 2 | 0 3 4 0 | 0 5 6 0 | 7 0 0 1",
               :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Int>>.Array;

die "The rows must have the same size" unless [==] $matrix>>.elems;

die "The number of rows and columns are not the same"
  unless $matrix.elems ==  $matrix[0].elems;

my $size = $matrix.elems;

for ^$size -> $row
{
  for ^$size -> $col
  {
    my $is-on-x = on-the-x(:$row, :$col, :$size);
    my $value   = $matrix[$row][$col];
    my $ok      = $is-on-x ?? $value != 0 !! $value == 0;

    say ": [$row,$col]: $value { $is-on-x ?? "X" !! "-" } { $ok ?? "ok" !! "error" }" if $verbose;

    unless $ok
    {
      say 'false';
      exit;
    }
  }
}

say 'true';

sub on-the-x (:$row, :$col, :$size)
{
  my $last-index = $size -1;
  
  return True if $row == $col;
  return True if $last-index - $row == $col;
  return False;
}
