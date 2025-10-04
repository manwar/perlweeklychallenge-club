#! /usr/bin/env raku

unit sub MAIN (:s(:$str) where $str ~~ /^ <[a..z A..Z \s]>+ $/,
               :k(:$keys) where $keys ~~ /^ <[a..z]>* $/,
               :v(:$verbose));

my @words     = $str.lc.words;
my @keys      = $keys.lc.comb;
my @typeable  = @words.grep({ .contains(none(@keys)) });

die "Duplicate keys" if @keys.repeated;

if $verbose
{
  say ": Words: { @words.map({ "'$_'" }).join(", ") }";
  say ": Keys: { @keys.map({ "'$_'" }).join(", ") }";
  say ": Typeable words: { @typeable.map({ "'$_'" }).join(", ") }";
}

say @typeable.elems;
