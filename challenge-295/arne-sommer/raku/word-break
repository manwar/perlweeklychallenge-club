#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               *@words where @words.elems > 1,
               :v(:$verbose));

for @words.permutations -> @permutation
{
  my $permutation = @permutation.join;

  say ": Testing '$permutation'" if $verbose;

  if $str ~~ /$permutation/
  {
    say 'true';
    exit;
  } 
}

say 'false';
