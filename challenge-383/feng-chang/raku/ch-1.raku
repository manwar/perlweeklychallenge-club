#!/bin/env raku

unit sub MAIN(Str:D $L1, Str:D $L2, Str:D $L3);

use MONKEY-SEE-NO-EVAL;

my @list1 = EVAL $L1;
my @list2 = EVAL $L2;
my @list3 = EVAL $L3;

my %trans;
@list3.map(-> @a { %trans{@a[$_]} = @a[0] for 1..(+@a-1) });

my @L1 = @list1.map({ %trans{$_} ?? %trans{$_} !! $_});
my @L2 = @list2.map({ %trans{$_} ?? %trans{$_} !! $_});
put @L1 eqv @L2;
