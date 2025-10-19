#! /usr/bin/env raku

unit sub MAIN (*@rows where @rows.elems == @rows[0].chars
	         && all(@rows) ~~ /^ <[01]> ** { @rows[0].chars } $/,
               :v(:$verbose));

my @matrix       = @rows>>.comb>>.Array;
my @team-numbers = ^@matrix.elems;
my $size         = @matrix.elems;
my $iteration    = 1;

loop
{
  my %res = winners(@matrix, @team-numbers);

  @matrix  = @(%res<matrix>);
  @team-numbers = @(%res<team-numbers>);
  
  last if @team-numbers.elems == $size || @team-numbers.elems == 1;
  $size = @team-numbers.elems;
}

say @team-numbers.join(", ");

sub winners (@matrix, @team-numbers)
{
  my @scores = @matrix>>.sum;
  my $max    = @scores.max;

  if $verbose
  {
    say ": Iteration { $iteration++ } (with size { @matrix.elems })";
    my $i = 0;
    for ^@matrix.elems -> $team
    {
      say ": Team {@team-numbers[$i++]} has score @scores[$team] (values [ @matrix[$team].join(", ") ]) { @scores[$team] == $max ?? "MAX" !! "" }";
    }
  }

  my @maxes  = (0 .. @scores.end).grep({ @scores[$_] == $max });
  my @new-matrix;
  my @new-team-numbers;
 
  # return { matrix => $max, team-numbers => @team-numbers[@maxes[0]] } if @maxes.elems == 1;

  for ^@matrix.elems -> $i
  {
    next unless $i == any(@maxes);
    @new-team-numbers.push: @team-numbers[$i];
    my @row;
    for ^@matrix.elems -> $j
    {
      next unless $j == any(@maxes);
      @row.push: @matrix[$i;$j];
    }
    @new-matrix.push: @row;
  }
  return { matrix => @new-matrix, team-numbers => @new-team-numbers };
}
