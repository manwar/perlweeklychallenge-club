#! /usr/bin/env raku

unit sub MAIN ($numbers = "2 5 4 4 5 5 2");

my @numbers = $numbers.words;

die "Positive integers only" unless all(@numbers) ~~ /^<[1..9]>\d*$/;

my %count = @numbers.Bag;

my @odd = %count.keys.grep({ %count{$_} % 2 });

die "Did not find one (and only one) match. Found: { @odd ?? @odd.join(", ") !! 'none' }" if @odd.elems != 1;

say @odd[0];
