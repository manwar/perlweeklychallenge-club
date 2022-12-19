#!/usr/bin/perl
use strict;
use warnings;

# put all examples into an array
my @lists = (
   [1,3,4,5,7],
   [1,2,3,6,7,9],
   [0,1,2,4,5,6,8,9]
);

# iterate over all examples and get the results, then print them
foreach my $list (@lists) {
   my @ranges = ranges(@$list);
   print "(" . join(", ", @$list) . ") has ranges " . join(", ", @ranges) . "\n";
}

# function to get the output for a given list
sub ranges {
   my @array = @_;
   my @result;
   my $last = undef; # for last element during iteration
   my $begin = undef; # for last begin of a range
   foreach my $elem (@array) {
      if(defined($last)) {
         if($last+1 == $elem) {
            # We're in a range.
            # If $begin wasn't defined, we can set it to $last
            $begin //= $last;
            # Since we're in a range, we can set $last to the current element
            # for the next iteration
            $last = $elem;
         } else {
            # we're no longer in a range, or we weren't in one in the
            # first place
            if($begin != $last) {
               # we were in a range, so put the range into the @result
               push @result, "[$begin,$last]";
            }
            # Since we're now not in a range, let's start from scratch
            $begin = $last = $elem;
         }
      } else {
         # $last not defined, so first element in the list
         # initialize both $last and $begin with the current element
         $begin = $last = $elem;
      }
   }
   if($begin != $last) {
      # we didn't save the last range in the @result yet, so let's do it now
      push @result, "[$begin,$last]";
   }
   return @result;
}
