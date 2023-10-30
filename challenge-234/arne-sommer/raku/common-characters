#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0 && all(@words) ~~ /^<[a..z]>+$/, :v(:$verbose));

my @bags   = @words>>.comb>>.Bag;
my @common = ( [(&)] @bags ).kxxv;

say ":Bags: { @bags.raku }" if $verbose;

my $common =  @common.BagHash;
my @sorted;

for @words[0].comb -> $letter
{
  say ": Considering first word letter $letter" if $verbose;
  next unless $common{$letter};
  $common{$letter}--;
  @sorted.push: $letter;
  say ": - Added letter $letter (remaining count: $common{$letter})" if $verbose;
}

say "({ @sorted.map( '"' ~ * ~ '"').join(", ") })";
