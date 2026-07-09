#! /usr/bin/env raku

unit sub MAIN ($string = "1 2 5 | 5 1 2 | 2 5 1",
               :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Numeric;
my $rows   = $matrix.elems;
my $cols   = $matrix[0].elems;
my @target = 1 .. $cols;

die "The rows must have the same size" unless [==] $matrix>>.elems;
die "The matrix must have the same number of rows and columns" unless $rows == $cols;
die "Must contain integers only" unless all($matrix[*;*]) ~~ Int;

if $verbose
{
  say ":Matrix: { $matrix.raku }";
  say ":Target: @target[]";
}

say same-row-column($matrix, @target);

sub same-row-column ($matrix, @target)
{
  for ^$cols -> $col
  {
    my @col      = $matrix[*;$col];
    my @col-sort = @col.sort;
    my $is-ok    = @col-sort eqv @target;

    say ":Column $col: @col[] is { $is-ok ?? "ok" !! "not ok" }" if $verbose;

    return False unless $is-ok;

    my @row      = $matrix[$col];
    my @row-sort = @row.sort; 
       $is-ok    = @col-sort eqv @target;

    say ":Row $col: @row[] is { $is-ok ?? "ok" !! "not ok" }" if $verbose;

    return False unless $is-ok;
  }

  return True;
}

