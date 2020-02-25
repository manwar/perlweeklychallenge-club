#! /usr/bin/env raku

sub MAIN (:$verbose, *@strings)
{
  @strings = ('I L O V E Y O U', '2 4 0 3 2 0 1 9', '! ? £ $ % ^ & *') unless @strings.elems;

  my @arrays = @strings.map(*.words.List);
  
  my $length = @arrays>>.elems.max; 
  my @width  = @arrays>>.chars>>.max;

  if $verbose
  {
    say ":A: { @arrays.perl }";
    say ":L: $length";
    say ":W: { @width }";
  }

  for ^$length -> $index
  {
    my $col = 0;
    for @arrays
    {
      print "{ ($_[$index] // '').fmt("%-{ @width[$col] }s") } ";
      $col++;
    }
    say "";
  }
}
