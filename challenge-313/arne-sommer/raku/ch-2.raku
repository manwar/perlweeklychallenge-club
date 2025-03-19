#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

my @str     = $str.comb;
my @letters = @str.grep( /<:L>/ );

if $verbose
{
  say ": Letters: { @letters.join(",") }";
  say ": Reverse: { @letters.reverse.join(",") }";
}

@str.map({ /<:L>/ ?? @letters.pop !! $_ }).join.say;
