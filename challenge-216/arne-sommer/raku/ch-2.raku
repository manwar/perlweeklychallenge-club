#! /usr/bin/env raku

unit sub MAIN (:w(:$word) where $word.chars >= 1 && $word ~~ /^<[a..z]>+$/;
               *@stickers where @stickers.elems > 0 && all(@stickers) ~~ /^<[a..z]>+$/,
               :v(:$verbose));

my @word = $word.comb;

say ": Word: { @word.sort.join(",") }" if $verbose;

for (@stickers xx $word.chars).flat.combinations(1 .. Inf).unique(:as(&bag)) -> @combination
{
  my $stickers = @combination.elems;
  my @stickers = @combination.join.comb;

  say ": $stickers Sticker(s) ({ @combination.join(",") }) - Letters: { @stickers.sort.join(",") } " if $verbose;

  if @word.Bag (<=) @stickers.Bag
  {
    say $stickers;
    exit;
  }
}

say 0;

