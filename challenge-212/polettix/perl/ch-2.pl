#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

@ARGV = (3, 1, 2, 3, 5, 1, 2, 7, 6, 3) unless @ARGV;
if (my @rearranged = rearrange_groups(@ARGV)) {
   say join ', ', map { '(' . join(',', $_->@*) . ')' } @rearranged;
}
else {
   say -1;
}

sub rearrange_groups ($size, @list) {
   return if @list % $size;

   my @inputs;
   for my $item (sort { $a <=> $b } @list) {
      push @inputs, [$item, 0] if (!@inputs) || ($item != $inputs[-1][0]);
      $inputs[-1][1]++;
   }

   my $n_groups = @list / $size;
   my @groups;
   for (1 .. $n_groups) {
      push @groups, \my @group;
      my $cursor = 0;
      for (1 .. $size) {
         return if $cursor > $#inputs; # failed!
         my $candidate = $inputs[$cursor][0];
         return if @group && $candidate != $group[-1] + 1;
         push @group, $candidate;
         $inputs[$cursor][1]--;
         if ($inputs[$cursor][1] <= 0) {
            splice @inputs, $cursor, 1;
         }
         else {
            ++$cursor;
         }
      }
   }

   return @groups;
}
