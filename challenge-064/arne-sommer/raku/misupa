#! /usr/bin/env raku

multi MAIN (:$verbose)
{
  MAIN(lines().join, :$verbose);
}

multi MAIN ($file where $file.IO.e, :$verbose)
{
  MAIN($file.IO.lines().join, :$verbose);
}

multi MAIN (Str $string is copy where ! $string.IO.e, :$verbose)
{
  subset PositiveIntZero of Int where * >= 0;
  
  my @matrix;

  while $string ~~ /"[" (.*?) "]" (.*)/
  {
    $string = $1.Str.trim;

    say ":: Row: $0" if $verbose;

    my @values = $0.words>>.Int;
    die "Illegal value in row $0" unless all(@values) ~~ PositiveIntZero;

    @matrix.push: @values;
  }

  my @path = (); 
  my $best = Inf;
  my $last_row = @matrix.elems - 1;
  my $last_col = @matrix[0].elems -1;

  die "Not the same length on the rows" unless [==] @matrix>>.elems;

  traverse((@matrix[0;0],), 0, 0);

  for @path -> @current
  {
    say "$best ( { @current.join(" → ") } )";
  }

  sub traverse (@my-path, $x, $y)
  {
    if $x == $last_row && $y == $last_col
    {
      my $sum = @my-path.sum;
      say ":: At the end with sum $sum and path: @my-path[]" if $verbose;
      ( $best = $sum; @path = () ) if $sum < $best;
      @path.push: @my-path if $sum == $best;
      return;
    }

    say ":: Currently at pos: [$x,$y] with path: @my-path[]" if $verbose;
  
    if $x < $last_row
    {
      my @new-path = @my-path;
      @new-path.push: @matrix[$x+1;$y];
      traverse(@new-path, $x+1, $y);
    }
    if $y < $last_col
    {
      my @new-path = @my-path;
      @new-path.push: @matrix[$x;$y+1];
      traverse(@new-path, $x, $y+1);
    }
  }

}
