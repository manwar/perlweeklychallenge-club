#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems > 1 && all(@nums) ~~ Int,
               :v(:$verbose));

my $count = 0;

for 0 .. @nums.end -1 -> $i
{
  for $i + 1 .. @nums.end -> $j
  {
    if @nums[$i] > 2 *@nums[$j]
    {
      say ": ($i, $j) => nums[$i] = @nums[$i], nums[$j] = @nums[$j], @nums[$i] > 2 * @nums[$j]" if $verbose;
      $count++;
    }
  }
}

say $count;
