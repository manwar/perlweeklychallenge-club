#! /usr/bin/env raku

unit sub MAIN ($list1, $list2);

my @list1 = $list1.words;
my @list2 = $list2.words;
my $bag1  = @list1.BagHash;

my @sorted;

for @list2 -> $element
{
  @sorted.append: $element xx $bag1{$element};

  $bag1{$element}:delete;
}

@sorted.append: $bag1.kxxv.sort;

say "({ @sorted.join(", ") })";
