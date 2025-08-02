#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int && all(@ints) > 0,
               :v(:$verbose));

my $elem-sum = @ints.sum;
my $digit-sum = @ints>>.comb>>.sum.sum;

if $verbose
{
  say ": Element sum: $elem-sum";
  say ": Digit sum: $digit-sum";
}

say abs($elem-sum - $digit-sum);
