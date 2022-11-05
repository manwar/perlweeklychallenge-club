#!/usr/bin/env raku
use v6;
sub MAIN (*@array) {
   @array = 2, 1, 2, 1, 1 unless @array;
   my @ad = array-degree(@array);
   put '(', @ad.join(', '), ')';
}

sub array-degree (@array) {
   my %data-for;
   my @letter-for = {},;
   for @array.kv -> $i, $item {
      my $data = %data-for{$item} //= { start => $i, count => 0 };
      $data<stop> = $i;
      $data<length> = 1 + $i - $data<start>;
      @letter-for[$data<count>++]{$item}:delete;
      @letter-for[$data<count>]{$item} = $data;
   }
   my $best = @letter-for[*-1].values.sort({$^a<length> <=> $^b<length>})[0];
   return [@array[$best<start> .. $best<stop>]];
}
