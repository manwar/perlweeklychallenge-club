#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 1 && all(@words) ~~ /^<[a..z]>+$/,
               :a(:$alien) where $alien.comb.sort.join eq "abcdefghijklmnopqrstuvwxyz",
               :v(:$verbose));

my @alien = $alien.comb;
my @alpha = 'a' .. 'z';
my %alien;
my %words;

for @alpha -> $char
{
  %alien{$char} = @alien.shift;
  say ": char $char -> %alien{$char}" if $verbose;
}

for @words -> $word
{
  %words{$word} = alienate($word);
  say ": word $word -> %words{$word}" if $verbose;
}

sub alien ($char)
{
  return %alien{$char};
}

sub alienate ($string)
{
  return $string.comb>>.&alien.join;
}

my @sorted = @words.sort({ %words{$^a} cmp %words{$^b} });

say "({ @sorted.map('"' ~ * ~ '"').join(", ") })";
