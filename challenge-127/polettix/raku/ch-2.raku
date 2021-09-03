#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @intervals = @args ?? @args !!
      ((1, 4), (3, 5), (6, 8), (12, 13), (3, 20));
   for @intervals -> $interval is rw {
      $interval = $interval.comb(/\d+/).Array if $interval ~~ Str;
   }
   print-intervals(conflict-intervals(@intervals));
}

sub print-intervals (@intervals) {
   print '[ ';
   @intervals.map({"({$_[0]},{$_[1]})"}).join(', ').print;
   print ' ' if @intervals;
   put ']';
} ## end sub print_intervals (@intervals)

sub conflict-intervals (@intervals) {
   return gather {
      while @intervals {

         # if there is a "first" one, it's safe because it has not been
         # eliminated by its predecessors. Its endpoints will be used to
         # possibly eliminate successors, we keep them in two convenience
         # variables.
         my ($X, $Y) = @intervals.shift.Slip;

         # we filter the remaining intervals ditching all those that
         # conflict with ($X, $Y) or whatever it becomes on the way. In
         # particular, at every conflict we expand ($X, $Y) to also
         # include the conflicting item, because we will ditch it from
         # the candidate "clean" intervals and put it in @conflicting.
         @intervals = @intervals.grep: -> $interval {
            my ($A, $B) = |$interval;

            # this is a general check to see if the two intervals are
            # disjoint. It assumes that touching intervals are conflicting.
            ($A - $Y) * ($B - $X) > 0 or do {
               take $interval;
               $X = $A if $X > $A;  # "eat" ($A, $B) in ($X, $Y)
               $Y = $B if $Y < $B;
               0; # this interval conflicted and does not get passed along
            }
         }
      }
   }
}
