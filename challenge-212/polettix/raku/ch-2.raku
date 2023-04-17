#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = 3, 1, 2, 3, 5, 1, 2, 7, 6, 3 unless @args;
   my $size = @args.shift;
   if (my $rearranged = rearrange-groups($size, @args)) {
      say $rearranged;
   }
   else {
      put -1;
   }
}

sub rearrange-groups ($size, @list) {
   return if @list.elems % $size;

   my @inputs;
   for @list».Int.sort -> $item {
      @inputs.push: [$item, 0] if (!@inputs) || ($item != @inputs[*-1][0]);
      @inputs[*-1][1]++;
   }

   my $n-groups = @list.elems div $size;
   my @groups;
   for ^$n-groups {
      my @group;
      my $cursor = 0;
      for ^$size {
         return if $cursor > @inputs.end; # failed!
         my $candidate = @inputs[$cursor][0];
         return if @group && $candidate != @group[*-1] + 1;
         @group.push: $candidate;
         @inputs[$cursor][1]--;
         if (@inputs[$cursor][1] <= 0) {
            @inputs.splice($cursor, 1);
         }
         else {
            ++$cursor;
         }
      }
      @groups.push: @group;
   }

   return @groups;
}
