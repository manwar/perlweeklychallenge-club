#!/usr/bin/env raku

# see usage:
#
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-091/pkmnx/raku$ echo "1,2,1,2" | ./ch-2.raku 
#  Input: @N = (1, 2, 1, 2)
#  Output: 1
#  
#  Reason: 
#  at index (0) jump 1
#  at index (1) jump 2
#  at index (3) jump 2
#  and index 3 (value: 2) is the final element in our array!

sub MAIN () {

   my @nums = lines.comb(/\d+/);
   die "not enough nums!" if @nums.elems < 2;

   my $indx = 0;
   my $lastIndx = 0;

   my @steps = ();
   my $break = False;

   while ( $indx <= (@nums.elems -1) ) {
      $lastIndx = $indx;
      @steps.push( sprintf "at index (%d) jump %d", $lastIndx, @nums[$indx] );
      $indx += @nums[$indx];
      if ( $lastIndx == $indx ) {
         $break = True;
         last;
      }
   }

   my $ok = False;
   if ( $lastIndx  == (@nums.elems -1) ) {
      $ok = True;
      @steps.push( sprintf "and index %d (value: %d) is the final element in our array!", $lastIndx, @nums[$lastIndx]);
   } 
   elsif ( $break ) {
      @steps.push( sprintf "but, we jumped in a non moveable position before reaching the end of our array!");
   }
   else {
      @steps.push( sprintf "but, for index (%d) we would overshoot the array of %d numbers!", $indx, @nums.elems);
   }

   printf "Input: @N = (%s)\n", @nums.join(", ");
   ("Output: " ~ ($ok and "1" or "0") ).say;

   "\nReason: ".say;
   @steps.join("\n").say;

}
