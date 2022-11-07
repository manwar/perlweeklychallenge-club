use v6;

=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-11-07

Challenge 190 Capital Detection ( Raku )



You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate

if it satisfies at least one of the following rules:



1) Only first letter is capital and all others are small.

2) Every letter is small.

3) Every letter is capital.



=end comment



my @words = ("Perl", "TPF", "PyThon", "raku");



for (@words) -> $s {

  say "Input: \$s = \'$s'";

  if ($s ~~ /^<:Lu><:Ll>*$/) {

    say "Output: 1";

  } elsif ( $s ~~ /^<:Ll>*$/) {

    say "Output: 2";

  } elsif ($s ~~ /^<:Lu>*$/) {

    say "Output: 3";

  } else {

    say "Output: 0";

  }

  say " ";

}



=begin comment

SAMPLE OUTPUT

PS G:\Projects\Perl\Challenges> raku .\CapitalDetection.rk

Input: $s = 'Perl'

Output: 1



Input: $s = 'TPF'

Output: 3



Input: $s = 'PyThon'

Output: 0



Input: $s = 'raku'

Output: 2



=end comment
