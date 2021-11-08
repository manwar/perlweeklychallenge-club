#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub conflict_intervals (@intervals) {
   my @conflicting; # keep the answer
   while (@intervals) {

      # if there is a "first" one, it's safe because it has not been
      # eliminated by its predecessors. Its endpoints will be used to
      # possibly eliminate successors, we keep them in two convenience
      # variables.
      my ($X, $Y) = shift(@intervals)->@*;

      # we filter the remaining intervals ditching all those that
      # conflict with ($X, $Y) or whatever it becomes on the way. In
      # particular, at every conflict we expand ($X, $Y) to also
      # include the conflicting item, because we will ditch it from
      # the candidate "clean" intervals and put it in @conflicting.
      @intervals = grep {
         my ($A, $B) = $_->@*;

         # this is a general check to see if the two intervals are
         # disjoint. It assumes that touching intervals are conflicting.
         ($A - $Y) * ($B - $X) > 0 or do {
            push @conflicting, $_;
            $X = $A if $X > $A;  # "eat" the ($A, $B) interval in ($X, $Y)
            $Y = $B if $Y < $B;
            0; # this interval conflicted and does not get passed along
         }
      } @intervals;
   }
   return @conflicting;
}

sub print_intervals (@intervals) {
   print {*STDOUT} '[ ';
   print {*STDOUT} join ', ', map { ; "($_->[0],$_->[1])" } @intervals;
   print {*STDOUT} ' ' if @intervals;
   say {*STDOUT} ']';
} ## end sub print_intervals (@intervals)

my @intervals =
  @ARGV ? @ARGV : ([1, 4], [3, 5], [6, 8], [12, 13], [3, 20]);
$_ = ref($_) ? $_ : [m{(\d+)}gmxs] for @intervals;
print_intervals(conflict_intervals(@intervals));
