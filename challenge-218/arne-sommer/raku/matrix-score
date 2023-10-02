#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "0 0 0 1 | 1 0 1 0 | 1 1 0 0", :v(:$verbose));

my @matrix = $matrix.split("|")>>.words>>.Array;
my @rows   = @matrix>>.elems;

die "Must have at least 1 row" unless @rows.elems >= 1;
die "The rows must have the same size" unless [==] @rows;
die "Must contain 0 and 1 only" unless all(@matrix[*;*]) eq any(0,1);

my $cols = @matrix[0].elems;

say ": Matrix: { @matrix.raku } " if $verbose;
say ": - Size: rows:$rows cols:$cols" if $verbose;

for ^$rows -> $row-id
{
  print ": - row $row-id " if $verbose;

  if @matrix[$row-id][0] == 0
  {
    say " - swapping" if $verbose;
    @matrix.&flip-row($row-id);
    say ": Matrix: { @matrix.raku } " if $verbose;
  }
  else
  {
    say " - ok" if $verbose;
  }
}

for ^$cols -> $col-id
{
  my @cols = (^@matrix.elems).map({ @matrix[$_][$col-id] });
  
  print ": - col $col-id -> @cols[]" if $verbose;

  if @cols.sum < $cols / 2
  {
    say " - swapping" if $verbose;
    @matrix.&flip-col($col-id);
    say ": Matrix: { @matrix.raku } " if $verbose;
  }
  else
  {
    say " - ok" if $verbose;
  }
}

say ": Final matrix: { @matrix.raku }" if $verbose;

say @matrix.map({ @$_.join.parse-base(2) }).sum;

sub flip-row(@matrix, UInt $row)
{
  @(@matrix[$row]).=map({ $_ == 1 ?? 0 !! 1 } );

  return @matrix;
}

sub flip-col(@matrix, UInt $col)
{
  (^@matrix.elems).map({ @matrix[$_][$col] = + ! + @matrix[$_][$col] });

  return @matrix;
}