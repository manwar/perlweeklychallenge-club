#! /usr/bin/env raku

unit sub MAIN ($string = "1 0 0 1 | 0 1 0 2 | 0 0 1 3", :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Int>>.Array;

die "The rows must have the same size" unless [==] $matrix>>.elems;

say + (rule1($matrix) && rule2($matrix) && rule3($matrix) && rule4($matrix));

sub rule1 ($matrix)
{
  for ^$matrix.elems -> $row-index
  {
    for $matrix[$row-index] -> $value
    {
      next if $value == 0;
      last if $value == 1;

      say ": Falsified by rule 1 (on row $row-index)" if $verbose;

      return False;
    }
  }

  say ": Verified by rule 1" if $verbose;

  return True;
}

sub rule2 ($matrix)
{
  my $ok = [>=] $matrix.map( { $_.all == 0 ?? 0 !! 1 });

  say ": Falsified by rule 2" if $verbose && ! $ok;
  say ": Verified by rule 2"  if $verbose && $ok;

  return $ok;
}

sub rule3 ($matrix)
{
  for ^($matrix.elems -1) -> $row-index
  {
    next if all($matrix[$row-index]) == 0;
    next if all($matrix[$row-index + 1]) == 0;

    my $pos1 = get-one($matrix[$row-index]);
    my $pos2 = get-one($matrix[$row-index +1]);

    if $pos1 >= $pos2
    {
      say ": Falsified by rule 3 (Row $row-index Col $pos1 vs Row { $row-index + 1  } Col: $pos2" if $verbose;
      return False;
    } 
  }

  say ": Verified by rule 3" if $verbose;
  return True;
}

sub rule4 ($matrix)
{
  for ^$matrix.elems -> $row-index
  {
    next if all($matrix[$row-index]) == 0;

    for ^$matrix[$row-index].elems -> $col-index
    {
      next if $matrix[$row-index][$col-index] == 0;
      unless $matrix[$row-index][$col-index] == 1
      {
        say ": Falsified by rule 4 (First non-zero is not one; row $row-index Col: $col-index" if $verbose;
        return False;
      }

      my @col = $matrix[*;$col-index];
      my $col = @col.Bag;

      unless $col.keys.elems == 2 && $col{1} == 1 && $col{0} > 0
      {
        say ": Falsified by rule 4 (row $row-index column $col-index)" if $verbose;
        return False;
      }

      last;
    }
  }

  say ": Verified by rule 4" if $verbose;
  return True;
}

sub get-one (@row)
{
  for ^@row.elems -> $index
  {
    return $index if @row[$index] == 1;
    die "Not a leading 0" unless @row[$index] == 0;
  }
  die "No 1 in row";
}


