#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0
                  && all(@words) ~~ /^ <[a..z]>**2..* $/
                  && ( [==] @words>>.chars ),
               :v(:$verbose));

my @signature = @words.map: { difference($_).raku };
my %count     = @signature.Bag;
my $index     = @signature.first: { %count{$_} == 1 }, :k;

if $verbose
{
  for @words -> $word
  {
    say ": $word => { difference($word).raku }";
  }
}

say @words[$index];

sub difference(Str $word)
{
  my @codes = $word.ords;
  my @diff = @codes[1..*] Z- @codes[0 ..^ @codes.elems - 1];
  @diff;
}