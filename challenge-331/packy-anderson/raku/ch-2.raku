#!/usr/bin/env raku
use v6;

sub buddyString($source, $target) {
  # put the source characters in an array
  my @source = $source.comb;
  # loop over the first to all but last characters
  for 0 .. @source.elems - 2 -> $i {
    # generate a list of character positions
    my @slice = (0 .. @source.elems - 1);
    # swap the $i-th and following positions
    (@slice[$i], @slice[$i+1]) = (@slice[$i+1], @slice[$i]);
    # test to see if it matches the target!
    return True if @source[@slice].join('') eq $target;
  }
  # womp-womp! nothing matched!
  return False;
}

sub solution($source, $target) {
  say qq{Input: $source = "$source"};
  say qq{       $target = "$target"};
  say qq{Output: } ~ buddyString($source, $target);
}

say "Example 1:";
solution("fuck", "fcuk");

say "\nExample 2:";
solution("love", "love");

say "\nExample 3:";
solution("fodo", "food");

say "\nExample 4:";
solution("feed", "feed");