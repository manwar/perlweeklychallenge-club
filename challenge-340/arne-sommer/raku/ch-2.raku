#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

my @words    = $str.split(/\s/);
my @integers = @words.grep: * ~~ /^ 0 | (<[1..9]> <[0..9]>*) $/;

if $verbose
{
  say ": words: { @words.map({ "'$_'" }).join(", ") }";
  say ": integers: { @integers.map({ "'$_'" }).join(", ") }";
}

say [<] @integers;