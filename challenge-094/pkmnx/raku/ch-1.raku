#!/usr/bin/env raku

# see usage:
#
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-094/pkmnx/raku$ echo "opt", "bat", "saw", "tab", "pot", "top", "was" | ./ch-1.raku
#  Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
#  Output: [
#    ("bat", "tab"),
#    ("saw", "was"),
#    ("opt", "pot", "top") ]
#

sub MAIN() {

   my $ws = [];
   for lines() -> $l {
      ( $l ~~ m:g:i/<[a .. z]>+/ ).map({ $ws.push( $_ ~ '' ) });
   }
   
   die ("Not enough input words!") if $ws.elems < 1;

   my $fn = -> $x { "(" ~ $x.map({ qq{"$_"} }).join(", ") ~ ")" };

   printf "Input: %s\n", $fn($ws);

   my $anag = {};
   $ws.map( -> $w {
      my $h = {};
      $w.comb().map({ $h{$_}++ });
      $anag{ 
         $h.keys.sort().map({ ($_, $h{$_}).join("|") }).join(";");
      }.push( $w );
   });

   my $out = [];  
   for $anag.kv -> $k, $v {
      $out.push( "   " ~ $fn($v) );
   }

   printf "Output: [\n%s ]\n",  $out.join(",\n");
   
}
