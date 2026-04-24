#! /usr/bin/env raku

unit sub MAIN ($paragraph where $paragraph.chars > 0,
               *@banned where @banned.elems > 0,
	       :a(:$all),
               :v(:$verbose) = $all);

my $words = $paragraph.split(/<[\s\,\.\!]>/).grep({ .chars > 0 })>>.lc.Bag;

my %banned = @banned.map: * => 1;

my $match;

for $words.sort({ $^b.value <=> $^a.value }) -> $word
{
  say ": word: '{ $word.key }' count: { $words{$word.key} } { %banned{$word.key} ?? "- banned" !! "- ok" }" if $verbose;
  
  next if %banned{$word.key};

  $match = $word.key unless $match;
  last unless $all;
}

say $match;