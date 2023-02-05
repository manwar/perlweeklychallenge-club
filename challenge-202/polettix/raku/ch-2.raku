#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @valley = widest-valley([@args.map({.comb(/\d+/)}).flat».Int]);
   put @valley.join(', ');
}


sub widest-valley (@altitudes) {
   return @altitudes if @altitudes < 2;    # trivial cases

   my $db       = 0;                       # start of a valley
   my $lb       = 0;                       # start of a level
   my $going_up = 0;                       # start going down
   my ($vb, $vl) = 0, 1;                   # best valley so far

   my $previous = @altitudes[0];
   for 1 ..^ @altitudes -> $i {
      my $current = @altitudes[$i];

      if $previous < $current {            # going up
         $lb       = $i;                   # reset the level begin
         $going_up = 1;                    # record the direction
      }

      # do nothing if $previous == $current

      elsif $previous > $current {         # going down
         if ($going_up) {    # leaving the top, "close" a valley
            my $length = $i - $db;
            ($vb, $vl) = $db, $length if $length > $vl;

            $db       = $lb;    # record the start of the new valley
            $going_up = 0;      # record the direction
         } ## end if ($going_up)
         $lb = $i;              # reset the level begin
      } ## end elsif ($previous > $current)

      $previous = $current;     # prepare for the next iteration
   } ## end for my $i (1 .. $#altitudes)

   # anyway, close the last segment
   my $length = @altitudes - $db;
   ($vb, $vl) = $db, $length if $length > $vl;

   return @altitudes[$vb .. ($vb + $vl - 1)];
} ## end sub widest_valley
