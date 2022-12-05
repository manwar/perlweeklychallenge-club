#! /usr/bin/env raku

unit sub MAIN (*@s where ( [==] @s>>.chars), :v(:$verbose));

my %diff;

for @s -> $string
{
  my @letters = $string.comb;
  my @diff;
  my $first;
  my $second = @letters.shift;
  while (@letters.elems) {
    my $first = $second;
    $second = @letters.shift;
    my $diff = $second.ord - $first.ord;
    @diff.push: $diff;
  }

  %diff{ @diff.join: " " }.push: $string;
  say ": $string -> @diff[]" if $verbose;
}

say ":" ~ %diff.raku if $verbose;

say %diff.grep({ $_.value.elems == 1 }).map( *.value ).Str;

