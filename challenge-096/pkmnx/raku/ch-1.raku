#!/usr/bin/env raku

# see usage:
#   
#   pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-096/pkmnx/raku$ cat poo 
#       Perl and   Raku are  part of the same family  
#   The Weekly Challenge
#   pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-096/pkmnx/raku$ time ./ch-1a.raku < poo 
#   Input: $S = "    Perl and   Raku are  part of the same family  "
#   Output: "family same the of part are Raku and Perl"
#   Input: $S = "The Weekly Challenge"
#   Output: "Challenge Weekly The"
#   
#   real    0m0.167s
#   user    0m0.174s
#   sys     0m0.045s

sub MAIN() {
   for lines() {
      printf( "Input: \$S = \"%s\"\n", $_ );
      printf( "Output: \"%s\"\n", $_.words.reverse.join(" ") );
   }
}
