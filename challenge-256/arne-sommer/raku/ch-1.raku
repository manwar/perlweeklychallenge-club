#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0 && @words.elems == @words.unique.elems,
               :v(:$verbose));

my $words = @words.Set;
my $count = 0;

for $words.keys.sort -> $word
{
  my $reverse = $word.flip;

  if ($word eq $reverse)
  {
    say ":   Word $word is a palindrome" if $verbose;
  }
  elsif $words{$reverse}
  {
    $count++;
    say ": + Word $word has a reverse ({$reverse})" if $verbose;
  }
  elsif ($verbose)
  {
    say ":   Word $word does not have a reverse" if $verbose;
  }
}

say $count div 2;