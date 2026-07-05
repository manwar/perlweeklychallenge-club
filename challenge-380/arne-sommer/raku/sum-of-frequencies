#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[a .. z]>+ $/,
               :v(:$verbose));

my $bag = $str.comb.Bag;

my @vowels     = $bag<a e i o u>;
my @consonants = $bag<b c d f g h j k l m n p q r s t v w x y z>;

my $max-vowel       = @vowels.max;
my $max-consonants  = @consonants.max;

if $verbose
{
  say ": Vovel Count: @vowels[] -> $max-vowel";
  say ": Consonant Count: @vowels[] -> $max-consonants";
}

say $max-vowel + $max-consonants;
