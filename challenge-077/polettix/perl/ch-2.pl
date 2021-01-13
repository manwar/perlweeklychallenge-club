#!/usr/bin/env perl
use strict;
use warnings;
use English qw< -no_match_vars >;
use autodie;

main(@ARGV);

sub main {
   my ($filename) = @_;
   my $fh;
   open $fh, '<', $filename if defined $filename;
   print {*STDOUT} count_solitaries($fh || \*STDIN), "\n";
}

# We will keep the "previous" line (initialized with all 'O' chars)
# and the "current" line. At each iteration, we can complete the count
# for the previous line and start counting for the current one. The last
# line will be counted after the loop iterating over the input.
sub count_solitaries {
   my ($fh) = @_;

   # this will keep track of the two lines. $lines[0] is the "previous"
   # and $lines[1] is the "current
   my @lines;

   # same for counts of items around
   my @counts;

   # handy variable to initialize counts in each iteration
   my @zeros;

   # return value
   my $n_solitaries = 0;

   while (<$fh>) {
      my @line = split m{\s+}mxs ;

      # some initialization, only done at the first iteration actually
      if (! @zeros) {
         @zeros = (0) x @line;
         @counts = [@zeros];
         @lines  = [('O') x @line];
      }

      # now we can put the "current" stuff
      push @counts, [@zeros];
      push @lines,  \@line;

      # the actual counting is performed by a "workhorse" function, so that
      # we can also call it later for the last line
      $n_solitaries += _count_solitaries(\@lines, \@counts);
      shift @lines;
      shift @counts;
   }

   # we still miss the count for the last line, so we call the workhorse
   # function once again
   return $n_solitaries + _count_solitaries(\@lines, \@counts);
}

# workhorse function, performs one single sweep updating the counts for
# the previous and the current lines. It returns the number of solitaire
# items for the previous line, because they're final at this stage.
sub _count_solitaries {
   my ($lines, $counts) = @_;

   # in the last call we are only left with the last "previous" line, so
   # we skip the sweeping part.
   if (@$lines > 1) {
      # we avoid the beginning and the ending chars because they are
      # brackets, so the column index iterator $i starts at 1 and ends
      # one before the last
      for my $i (1 .. $#{$lines->[1]} - 1) {
         # $j iterates over the three column indexes affected by $i
         for my $j ($i - 1 .. $i + 1) {
            # this is the previous line affecting the current count
            $counts->[1][$j]++ if $lines->[0][$i] eq 'X';

            # this is the current line affecting the previous and the
            # current counts
            if ($lines->[1][$i] eq 'X') {
               $counts->[0][$j]++;
               $counts->[1][$j]++; # self-counting is OK
            }
         }
      }
   }

   # the previous line/counts are over now, we can count how many
   # solitaires were there. 'grep' in scalar context returns a count.
   return scalar grep {
      $lines->[0][$_] eq 'X' &&  # a solitaire is a 'X' character...
      $counts->[0][$_] == 1;     # with a 1 count (i.e. only itself)
   } 1 .. $#{$lines->[0]} - 1;
}
