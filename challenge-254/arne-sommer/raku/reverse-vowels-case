#! /usr/bin/env raku

unit sub MAIN ($s, :v(:$verbose));

my @letters = $s.comb;
my @vowels  = @letters.grep: * ~~ /<[aeiouAEIOU]>/;
my @reverse = @vowels.reverse;

if $verbose
{
  say ":Letters: { @letters.join(",") }";
  say ":Vovels: { @vowels.join(",") }";
  say ":Reverse: { @reverse.join(",") }";
}

my @output = @letters.map({
	       if    /<[aeiou]>/ { @reverse.shift.lc; }
	       elsif /<[AEIOU]>/ { @reverse.shift.uc; }
	       else	         { $_;                }
             });

say @output.join;


