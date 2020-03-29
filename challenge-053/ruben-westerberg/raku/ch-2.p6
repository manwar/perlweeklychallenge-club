#!/usr/bin/env raku

my $n=@*ARGS[0]//2;
my @vowels= <a e i o u>;

die "Number not in range 1..5\n" unless $n ~~  1..5;

@vowels.combinations ==>	#<<Straight combos	
map {|.permutations} ==>	#<<create different orderings
grep {.elems == $n} ==>		#<<Only want length $n
grep {
	my $sum=0;
	my $s=join '', @$_;
	given ($s) {
		$sum+=m:g/a/;
		$sum-=m:g/a<[ie]>|a$/;

                $sum+=m:g/e/;
                $sum-= (m:g/ei|e$/);

                $sum+=m:g/i/;
                $sum-= m:g/i<[aeou]>|i$/;

                $sum+=m:g/o/;
                $sum-=m:g/o<[au]>|o$/;

                $sum+=m:g/u/;
                $sum-=m:g/u<[oe]>|u$/;
	}
	$sum==0;
} ==>
my @combinations;

.say for @combinations.map: {.join} ==> sort
