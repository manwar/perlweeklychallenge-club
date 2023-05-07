#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my $count = @args.shift;
   put number-placement-sequential(@args, $count);
   put number-placement-parallel(@args, $count);
}

sub number-placement-sequential (@numbers, $count) {
   my $av = zero-streaks-count(@numbers)
      .map({ (($_ - 1) / 2).Int })
      .sum;
   return $count <= $av ?? 1 !! 0;
}

sub number-placement-parallel (@numbers, $count) {
   my $av = zero-streaks-count(@numbers)
      .map({ $_ > 1 ?? $_ - 2 !! 0 })
      .sum;
   return $count <= $av ?? 1 !! 0;
}

sub zero-streaks-count (@numbers) {
   my @retval = 0,;
   for @numbers -> $n {
      if $n.Int { @retval.push: 0 if @retval[*-1] }
      else      { @retval[*-1]++                  }
   }
   @retval.pop while @retval && @retval[*-1] == 0;
   return @retval;
}
