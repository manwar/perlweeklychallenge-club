#! /usr/bin/env raku

unit sub MAIN (Str $string = "(1,1), (2,2), (3,3)", :v(:$verbose));

my @array = $string.EVAL;

say ": { @array.raku }" if $verbose;

my %matrix; @array.map({ %matrix{ $_[0] }{ $_[1] } = True });

say ": { %matrix.raku }" if $verbose;

my $answer;

for @array -> @current
{
  my ($row, $col) = @current;

  say ": [$row][$col]" if $verbose;;

  for (0,1),(1,-1),(1,0),(1,1) -> @add
  {
    my $maximum = traverse(1, $row, $col, @add[0], @add[1]);
    say "::: @add[] -> $maximum" if $verbose;
    $answer = max($answer, $maximum);
  }
}

say $answer;

sub traverse ($count, $row, $col, $add-row, $add-col)
{
  return $count unless %matrix{ $row + $add-row }{ $col + $add-col};

  return traverse($count +1, $row + $add-row, $col + $add-col, $add-row, $add-col);
}
