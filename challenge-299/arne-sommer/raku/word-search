#! /usr/bin/env raku

unit sub MAIN (:m(:$matrix)  = die("No matrix"),
               :w(:$word)    = die("No word"),
	       :a(:$all),
	       :v(:$verbose) = $all);

my @matrix = $matrix ~~ /\|/
  ?? $matrix.split("|")>>.words
  !! $matrix.words>>.comb;

die "Uneven row length" unless [==] @matrix>>.elems;

my $rows  = @matrix.elems;
my $cols  = @matrix[0].elems;
my $first = $word.substr(0,1);
my $chars = $word.chars;
my @todo;
my $found = False;

for ^$rows -> $row
{
  for ^$cols -> $col
  {
    if @matrix[$row][$col] eq $first
    {
      @todo.push: "$row,$col";
      say ": [$row,$col] == $first" if $verbose;
    }
  }
}

while (@todo.elems)
{
  my @path   = @todo.shift.flat;
  my $length = @path.elems;

  if $length == $chars
  {
    say ": Found Path: { @path.raku }" if $verbose;
    $found = True;
    last unless $all;
  }
  else
  {
    my $row-col     = @path.tail;
    my ($row, $col) = $row-col.split(",");
    my $new-char    = $word.substr(@path.elems, 1);

MOVE:
    for (0, -1), (-1, 0), (0, +1), (+1, 0) -> ($r,$c)
    {
      my $new-row = $row + $r;
      my $new-col = $col + $c;
      my $nrnc    = "$new-row,$new-col";
      
      for @path -> $pos
      {
        next MOVE if $pos eq $nrnc;
      }
      
      if 0 <= $new-col < $cols && 0 <= $new-row < $rows
      {
        if $new-char eq @matrix[$new-row][$new-col]
	{
          my @new-path = @path.clone;
	  @new-path.push: "$new-row,$new-col";
          say ": [$new-row,$new-col] == $new-char Path: {@new-path.raku } -> { $word.substr(0, @path.elems +1) }" if $verbose;
	  @todo.unshift: @new-path;
        }
      }
    }
  }
}

say $found;
