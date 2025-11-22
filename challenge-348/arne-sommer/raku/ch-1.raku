#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 1 && $str.chars %% 2,
               :y(:$y-is-a-vowel),
               :v(:$verbose));

my $first  = $str.substr(0, $str.chars / 2);
my $second = $str.substr($str.chars / 2);

my @vowels = $y-is-a-vowel
               ?? <A E I O U Y a e i o u y>
               !! <A E I O U a e i o u>;

my @first  = $first.comb.grep:  * eq any @vowels;
my @second = $second.comb.grep: * eq any @vowels;

if $verbose
{
  say ": First:  '$first' -> '{ @first.join }' size { @first.elems }";
  say ": Second: '$second' -> '{ @second.join }' size { @second.elems }";
}

say @first.elems == @second.elems > 0;
