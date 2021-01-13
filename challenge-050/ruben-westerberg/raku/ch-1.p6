#!/usr/bin/env raku

#merge intervals from command line


my $input=@*ARGS.join;
$input="[2,7], [3,9], [10,12], [15,19], [18,22]" unless @*ARGS;

s:g/\s+// given $input;
(m:g/\[(\d+)\,(\d+)\]/ given $input) ==> 
map({ (start=> .[0].Int, end=> .[1].Int).Hash;})==> 
sort({$^a<start> > $^b<start>})==>
my @ranges;
put  "Input ranges: ",join ", ", @ranges.map({sprintf("[%s,%s]",.<start>,.<end>)});
	
my @merged;

while @ranges {
	my $test=@ranges.shift;
	@ranges.=map({  
		do {
			my $contained=.<start> <= $test<start> <= .<end>;
			$contained||=$test<start> <= .<start> <=$test<end>;
			if $contained {
				$test<start> min= .<start>;
				$test<end> max= .<end>;
				|();
			}
			else {
				$_;
			}
		}
	});
	@merged.push: $test;
}
put  "Merged ranges: ",join ", ", @merged.map({sprintf("[%s,%s]",.<start>,.<end>)});
