#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ UInt && @ints.elems > 0, :v(:$verbose));

my $elem-sum  = @ints.sum;
my $digit-sum = @ints>>.comb>>.sum.sum;

say ": Elem sum: $elem-sum, Digit sum: $digit-sum" if $verbose;

say abs($elem-sum - $digit-sum);
