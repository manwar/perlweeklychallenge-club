#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use JSON::PP;

my ($greatness, $permutation) = great_permutation(@ARGV);
say $greatness, ' -> ', JSON::PP->new->encode($permutation);

say greatness(@ARGV);

sub great_permutation (@inputs) {
   my @sorted_indexes = sort { $inputs[$b] <=> $inputs[$a] } 0 .. $#inputs;

   my @permutation = (undef) x @inputs;

   # first pass - set greatness!
   my @pool;
   my @not_great;
   for my $index (@sorted_indexes) {
      my $value = $inputs[$index];
      if (@pool && $pool[0] > $value) {
         $permutation[$index] = shift @pool;
      }
      else {
         push @not_great, $index;
      }
      push @pool, $value;
   }

   my $greatness = scalar(@inputs) - scalar(@pool);

   # second pass - fill the rest
   @permutation[@not_great] = @pool;

   return ($greatness, \@permutation);
}

sub greatness (@inputs) {
   my %count_for;
   $count_for{$_}++ for @inputs;
   my @counts = @count_for{sort { $a <=> $b } keys %count_for};

   my $greatness = @inputs;
   my $pool = 0;
   for my $count (@counts) {
      next if $count <= $pool; # win & accumulate the same quantity
      $greatness -= $count - $pool; # not enough in pool, lose some
      $pool = $count;  # restart pool from this slot
   }
   return $greatness;
}
