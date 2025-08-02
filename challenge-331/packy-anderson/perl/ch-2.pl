#!/usr/bin/env perl
use v5.40;

sub buddyString($source, $target) {
  # put the source characters in an array
  my @source = split //, $source;
  # loop over the first to all but last characters
  foreach my $i (0 .. $#source - 1) {
    # generate a list of character positions
    my @slice = (0 .. $#source);
    # swap the $i-th and following positions
    ($slice[$i], $slice[$i+1]) = ($slice[$i+1], $slice[$i]);
    # test to see if it matches the target!
    return 'true' if join('', @source[@slice]) eq $target;
  }
  # womp-womp! nothing matched!
  return 'false';
}

sub solution($source, $target) {
  say qq{Input: $source = "$source"};
  say qq{       $target = "$target"};
  say qq{Output: } . buddyString($source, $target);
}

say "Example 1:";
solution("fuck", "fcuk");

say "\nExample 2:";
solution("love", "love");

say "\nExample 3:";
solution("fodo", "food");

say "\nExample 4:";
solution("feed", "feed");
