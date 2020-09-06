#! /usr/bin/env raku

unit sub MAIN ($dict where $dict.IO.f && $dict.IO.r = '/usr/share/dict/british-english',
               $grid where $grid.IO.f && $grid.IO.r = 'grid.txt',
	       :m(:$min-length) = 1,
	       :v(:$verbose));

my @grid = $grid.IO.lines.map( *.lc.words.list );

die "Uneven grid row length" unless [==] @(@grid)>>.elems;

die "Single characters only in the grid" if @(@grid)>>.chars>>.max.max > 1;

my %dict = get-dictionary($dict);
my @candidates;

my $rows = @grid.elems;
my $cols = @grid[0].elems;

for ^$rows -> $row
{
  for ^$cols -> $col
  {
    say ": [$row,$col]: @grid[$row][$col]" if $verbose;
    @candidates.append: get-candidates($row, $col);
  }
}

my @words = @candidates.unique.sort.grep({ %dict{$_} }).grep( *.chars >= $min-length);

say "Found {@words.elems} words of length $min-length or more: { @words.join(', ') }";

sub get-candidates ($row, $col)
{
  my @candidates = @grid[$row][$col],;

  for (-1, 0, 1) -> $r
  {
    for (-1, 0, 1) -> $c
    {
      say ": Pos $r, $c" if $verbose;

      @candidates.append: do-get-candidates($row, $col, $r, $c) unless $r == $c == 0;
    }
  }
  return @candidates;
}

sub do-get-candidates ($row is copy, $col is copy, $r, $c)
{
  my $current = @grid[$row][$col];

  my @candidates;

  loop
  { 
    $row += $r;
    $col += $c;

    last unless @grid[$row][$col].defined;
    
    $current ~= @grid[$row][$col];
    @candidates.push: $current;
  }

  return @candidates;
}

sub get-dictionary ($file where $file.IO.r)
{
  return $file.IO.lines.grep(* !~~ /\W/)>>.lc.Set;
}

