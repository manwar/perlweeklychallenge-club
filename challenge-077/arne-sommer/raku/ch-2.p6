#! /usr/bin/env raku

unit sub MAIN ($matrix where $matrix.IO.f && $matrix.IO.r = 'matrix1.txt',
	       :v(:$verbose));

my @matrix = $matrix.IO.lines.map( *.words.list );

die "Uneven grid row length" unless [==] @(@matrix)>>.elems;

die "Single characters only in the grid" if @(@matrix)>>.chars>>.max.max > 1;

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;

my $is_lonely = 0;

for ^$rows -> $row
{
  for ^$cols -> $col
  {
    say ": [$row,$col] -> @matrix[$row][$col] { is_lonely(@matrix, $row, $col) ?? 'is lonely' !! '' }" if $verbose;
    $is_lonely++ if is_lonely(@matrix, $row, $col);
  }
}

say $is_lonely;

sub is_lonely (@matrix, $row, $col)
{
  return False if @matrix[$row][$col] eq 'O';

  for (-1, 0, 1) -> $r
  {
    for (-1, 0, 1) -> $c
    {
      next if $r == $c == 0;
      next unless @matrix[$row + $r][$col + $c].defined;
      
      return False if @matrix[$row + $r][$col + $c] eq 'X';
    }
  }
  return True;
}
