#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my @list1;
while (@ARGV) {
   my $item = shift(@ARGV);
   last if $item eq '/';
   push @list1, $item;
}
my @m = minimum_index_sum(\@list1, \@ARGV);
say "(@m)";

sub minimum_index_sum ($list1, $list2) {
   my %list2_index_for;
   $list2_index_for{$list2->[$_]} //= $_ for 0 .. $list2->$#*;
   my @result;
   my $min_sum = scalar($list1->@*) + scalar($list2->@*);
   for my $i1 (0 .. $list1->$#*) {
      my $item = $list1->[$i1];
      defined(my $i2 = $list2_index_for{$item}) or next;
      my $this_sum = $i1 + $i2;
      if ($this_sum < $min_sum) { # new winner, reset
         @result = ($item);
         $min_sum = $this_sum;
      }
      elsif ($this_sum == $min_sum) { # append
         push @result, $item;
      }
      else {} # just skip this
   }
   return @result;
}
