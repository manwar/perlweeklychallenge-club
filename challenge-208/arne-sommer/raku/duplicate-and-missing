#! /usr/bin/env raku

unit sub MAIN ($nums = "1 2 2 4", :v($verbose));

my @nums = $nums.words;

die "Not increasing values" unless [<=] @nums;

my $duplicate = @nums.repeated;

say ": Duplicate: $duplicate" if $verbose;

my $current = @nums.shift;

while (@nums.elems)
{
  if @nums[0] != $current + 1
  {
    say ": Missing:  {  $current + 1 }" if $verbose;
    say "($duplicate, { $current + 1 })";
    exit;
  }
  $current = @nums.shift;
}

say "-1";
