#!/usr/bin/env raku

#
# see usage:
#
# pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-090/pkmnx/raku$ cat input.1
# GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG
# pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-090/pkmnx/raku$ ./ch-1.raku < input.1
# Input count: A: 14; C: 18; T: 22; G: 13
#          In: GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG
#         Out: CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC
#

sub MAIN() {

   my $map = { T => "A", A => "T", G => "C", C => "G" };
   my ($inCnt, $outCnt) = (0, 0);

   my $count = {};
   my @out = ();
   my @data = ();

   for lines() -> $l {
      @data = $l.comb(/./);
      for (@data) -> $c {
         $inCnt++;
         if ( $map{$c}:exists ) {  
            $outCnt++;
            $count{$c}++;
            @out.push( $map{$c} );
         } else {
         }
      }
   }

   die ( "bad input" ) if $inCnt != $outCnt;

   constant fmt = "%12s %s\n";

   printf fmt, "Input count:", $count.kv.map(-> $k, $v { "$k: $v" }).join("; ");
   printf fmt, "In:", @data.join("");
   printf fmt, "Out:", @out.join("");

}
