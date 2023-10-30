#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0, :w(:$very-verbose), :v(:$verbose) = $very-verbose);

my @result;

while @words
{
  my $first           = @words.shift;
  my $first-canonical = $first.comb.sort.unique.join;

  say ":First $first -> $first-canonical" if $very-verbose;

  for @words -> $second
  {
    my $second-canonical = $second.comb.sort.unique.join;

    say ":- Second $second -> $second-canonical" if $very-verbose;

    if $first-canonical eq $second-canonical
    {
      @result.push( ($first, $second) );
      say ":Pair {@result.elems }: similar words (\"$first\", \"$second\")" if $verbose;
    }
  }
}

say @result.elems;
