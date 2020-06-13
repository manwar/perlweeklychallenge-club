#! /usr/bin/env raku

sub MAIN ($string, *@words where @words.elems > 0, :$verbose)
{
  my $match = 0;
  for @words.permutations -> @candidate
  {
    my $wordlist = @candidate.map({ "\"$_\"" }).join(", ");
    say ": $wordlist" if $verbose;
    if @candidate.join eq $string
    {
      say $wordlist;
      $match++;
    }
  }
  say "0" unless $match;
}
