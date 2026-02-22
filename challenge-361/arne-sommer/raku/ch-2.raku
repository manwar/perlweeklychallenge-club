#! /usr/bin/env raku

unit sub MAIN ($string = "1 0 0 | 0 0 1 | 1 0 0",
               :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Numeric>>.Array;
my $rows   = $matrix.elems;
my $cols   = $matrix[0].elems;

die "The rows must have the same size" unless [==] $matrix>>.elems;
die "The matrix must have the same number of rows and columns" unless $rows == $cols;
die "Must contain 0s and 1s only" unless all($matrix[*;*]) ~~ one(0,1);


say ":Matrix: { $matrix.raku }" if $verbose;

for ^$cols -> $col
{
  my @col = $matrix[*;$col];

  say ":Considering column $col: @col[]" if $verbose;

# say $matrix[$index];

  if @col.sum == $cols -1
  {
    say ":Everybodey knows $col" if $verbose;

    # my $index = @col.grep(0, :k);

    if $matrix[$col;*].sum == 0
    {
      say ":and $col does not know anybody" if $verbose;
      say $col;
      exit;
    }
  }
}

say '-1';
