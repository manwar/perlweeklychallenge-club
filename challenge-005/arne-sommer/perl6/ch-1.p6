#! /usr/bin/env perl6

unit sub MAIN (Str $word is copy where $word !~~ /\W/,
  :$dictionary where $dictionary.IO.r = "/usr/share/dict/british-english");

$word .= lc;

my $dict = get-dictionary($dictionary);
 
print "Anagrams:";

for $word.comb.permutations>>.join.unique -> $candidate
{
  # next if $candidate eq $word;
  print " $candidate" if $dict{$candidate};
}
print "\n";

sub get-dictionary ($file where $file.IO.r) is export
{
  return $file.IO.lines.grep(* !~~ /\W/)>>.lc.Set;
}

