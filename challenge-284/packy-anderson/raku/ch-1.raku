#!/usr/bin/env raku
use v6;

sub luckyInteger(@ints) {
  my @lucky =
    @ints.Bag                      # count occurrences
         .pairs                    # get key/value pairs
         .grep({ .value == .key }) # keys that match freq
         .map({ .key })            # return just the keys
         .sort({ .Int });          # sort by integer value
  return -1 if @lucky == 0; # return -1 if no lucky int was found
  return @lucky[*-1]; # return the largest lucky int
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ luckyInteger(@ints);
}

say "Example 1:";
solution([2, 2, 3, 4]);

say "\nExample 2:";
solution([1, 2, 2, 3, 3, 3]);

say "\nExample 3:";
solution([1, 1, 1, 3]);
