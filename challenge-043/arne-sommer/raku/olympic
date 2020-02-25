#! /usr/bin/env raku

my @curr = (8, 0, 7, 0, 0, 0, 5, 0, 9);

for (1,2,3,4,6).permutations -> @permutation
{
  @curr[1,3,4,5,7] = @permutation;

  if @curr[0] + @curr[1]            ==     # Blue
     @curr[1] + @curr[2] + @curr[3] ==     # Yellow
     @curr[3] + @curr[4] + @curr[5] ==     # Black
     @curr[5] + @curr[6] + @curr[7] ==     # Green
     @curr[7] + @curr[8]            == 11  # Red
  {
    say "Values: @curr[] (from left to right)";
    say "Blue:   @curr[0] + @curr[1]";
    say "Yellow: @curr[1] + @curr[2] + @curr[3]";
    say "Black:  @curr[3] + @curr[4] + @curr[5]";
    say "Green:  @curr[5] + @curr[6] + @curr[7]";
    say "Red:    @curr[7] + @curr[8]";
    
    last;
  }
}
