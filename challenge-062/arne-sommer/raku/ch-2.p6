#! /usr/bin/env raku

use lib "lib";
use QueenCube;

unit sub MAIN
(
  $size     = 8,
  :$id       = 'Q',
  :$empty    =".",
  :$queen,
  :$colour,
  :$newlines,
  :$fill,
  :$random,
  :$silent,
  :$get-the-best,
  :$verbose
);

if $get-the-best
{
  get-the-best;
}
elsif $silent ~~ Int
{
  get-many-solutions;
}
else
{
  get-one-solution;
}

sub get-one-solution
{
  my $c = QueenCube.new(size => $size);

  $c.init($empty);

  if $queen
  {
    $c.queen($id, $_) for $queen.words;
  }

  if $fill || $random
  {
    loop
    {
      my $pos = $random ?? $c.get-empty-cell-random !! $c.get-empty-cell;
      last unless defined $pos;
      say ": Queen at $pos" if $verbose;
      my ($x, $y, $z) = $pos.split(";");
      $c.queen($id, $x, $y, $z);
    }
  }

  unless $silent
  {
    $newlines
      ?? $c.display-with-newlines($colour, $newlines)
      !! $c.display($colour);
  }

  my $count = $c.number-of-queens;
  say "Number of Queens: ", $count if $count > 1;

  return $count;
}


sub get-many-solutions
{
  my @result;

  @result.push(get-one-solution) for ^$silent;

  my %result;

  %result{$_}++ for @result;

  say "$_ (%result{$_})" for %result.keys.sort;
}


sub get-the-best
{
  my Int $best-count = 0;
  my $best-cube;
  
  my $c = QueenCube.new(size => $size);
  $c.init($empty);

  iterate($c);

  sub iterate ($cube)
  {
    for $cube.get-all-cells -> $cell
    {
      next unless $c.cell-is-free($cell);

      my $copy = $cube.clone;
      $copy.queen($id, $cell);

      iterate($copy);
    }
    
    my $q = $cube.number-of-queens;
    if $q > $best-count
    {
      say ": New best cube with $q Queens (old had $best-count)" if $verbose;
      $best-count = $q;
      $best-cube  = $cube
    }
    elsif $verbose
    {
      say ": Considering cube with $q Queens";
    }
  }
  
  $newlines
      ?? $c.display-with-newlines($colour, $newlines)
      !! $c.display($colour);

  say "Number of Queens: ", $best-count;
}
